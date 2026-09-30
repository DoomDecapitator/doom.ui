// src/tools/make_dist.mjs —— 把数据包本体打成发行 zip（确定性：同样的输入 ⇒ 逐字节同样的输出）。
//
//   node src/tools/make_dist.mjs            # 重新生成 dist/ 的 zip 与 SHA256SUMS.txt
//   node src/tools/make_dist.mjs --check    # 只校验：现成的 zip 与"现在重新打一次"是否逐字节相同（不同 ⇒ 退出码 1）
//
// 为什么自己写 zip：发行物必须可复现 —— 同样的包体重新打一次，字节要完全一样，
// 否则「dist 里的 zip 是不是这一版源码打的」就永远说不清。系统 zip / Compress-Archive
// 会写进本机时间戳与平台相关的属性 ⇒ 每次打出来的字节都不同。这里把时间戳钉死、条目排序钉死。
//
// 入口：<仓库根>/doom.ui/（data/ + mcdoc/ + pack.mcmeta），zip 内顶层目录 = doom.ui/。
// 出口：<仓库根>/dist/<name>.zip 与 <仓库根>/dist/SHA256SUMS.txt。
import fs from 'node:fs';
import path from 'node:path';
import zlib from 'node:zlib';
import crypto from 'node:crypto';
import { fileURLToPath } from 'node:url';

const TOOL = path.dirname(fileURLToPath(import.meta.url));
const ROOT = path.resolve(TOOL, '..', '..');
const PACK = path.join(ROOT, 'doom.ui');          // 数据包本体（顶层目录名 = 包名）
const DIST = path.join(ROOT, 'dist');
const NAME = 'doom.ui-v2.0-beta.zip';             // 附件名带版本号（SPEC §5）
const CHECK = process.argv.includes('--check');

// ---- CRC32（自实现：不依赖 Node 版本里的 zlib.crc32）----
const CRC_TABLE = (() => {
  const t = new Int32Array(256);
  for (let n = 0; n < 256; n++) { let c = n; for (let k = 0; k < 8; k++) c = c & 1 ? 0xEDB88320 ^ (c >>> 1) : c >>> 1; t[n] = c; }
  return t;
})();
function crc32(buf) { let c = -1; for (let i = 0; i < buf.length; i++) c = CRC_TABLE[(c ^ buf[i]) & 0xFF] ^ (c >>> 8); return (c ^ -1) >>> 0; }

// ---- 收集条目（文件 + 其所属目录），排序钉死 ----
function collect() {
  const files = [];
  const dirs = new Set();
  const walk = (d) => {
    for (const e of fs.readdirSync(d, { withFileTypes: true }).sort((a, b) => (a.name < b.name ? -1 : 1))) {
      const p = path.join(d, e.name);
      if (e.isDirectory()) { walk(p); }
      else files.push(p);
    }
  };
  walk(PACK);
  for (const f of files) {
    let rel = path.relative(ROOT, f).split(path.sep).join('/');   // 形如 doom.ui/data/...
    const parts = rel.split('/');
    for (let i = 1; i < parts.length; i++) dirs.add(parts.slice(0, i).join('/') + '/');
  }
  const names = [...files.map((f) => path.relative(ROOT, f).split(path.sep).join('/')), ...dirs];
  return names.sort((a, b) => (a < b ? -1 : a > b ? 1 : 0));
}

// ---- 写 zip（DOS 时间戳钉死在 1980-01-01 00:00:00）----
function buildZip(names) {
  const locals = [];
  const central = [];
  let offset = 0;
  for (const name of names) {
    const isDir = name.endsWith('/');
    const raw = isDir ? Buffer.alloc(0) : fs.readFileSync(path.join(ROOT, name));
    const deflated = zlib.deflateRawSync(raw, { level: 9 });
    const use = deflated.length < raw.length ? deflated : raw;
    const method = deflated.length < raw.length ? 8 : 0;
    const nameBuf = Buffer.from(name, 'utf8');
    const flag = /[^\x20-\x7e]/.test(name) ? 0x0800 : 0;   // 非 ASCII 名字标 UTF-8（EPFL 约定）
    const crc = crc32(raw);

    const lh = Buffer.alloc(30);
    lh.writeUInt32LE(0x04034b50, 0); lh.writeUInt16LE(20, 4); lh.writeUInt16LE(flag, 6);
    lh.writeUInt16LE(method, 8); lh.writeUInt16LE(0, 10); lh.writeUInt16LE(0x0021, 12);
    lh.writeUInt32LE(crc, 14); lh.writeUInt32LE(use.length, 18); lh.writeUInt32LE(raw.length, 22);
    lh.writeUInt16LE(nameBuf.length, 26); lh.writeUInt16LE(0, 28);
    locals.push(lh, nameBuf, use);

    const ch = Buffer.alloc(46);
    ch.writeUInt32LE(0x02014b50, 0); ch.writeUInt16LE(20, 4); ch.writeUInt16LE(20, 6);
    ch.writeUInt16LE(flag, 8); ch.writeUInt16LE(method, 10); ch.writeUInt16LE(0, 12); ch.writeUInt16LE(0x0021, 14);
    ch.writeUInt32LE(crc, 16); ch.writeUInt32LE(use.length, 20); ch.writeUInt32LE(raw.length, 24);
    ch.writeUInt16LE(nameBuf.length, 28); ch.writeUInt16LE(0, 30); ch.writeUInt16LE(0, 32);
    ch.writeUInt16LE(0, 34); ch.writeUInt16LE(0, 36); ch.writeUInt32LE(0, 38); ch.writeUInt32LE(offset, 42);
    central.push(ch, nameBuf);

    offset += lh.length + nameBuf.length + use.length;
  }
  const cd = Buffer.concat(central);
  const eocd = Buffer.alloc(22);
  eocd.writeUInt32LE(0x06054b50, 0); eocd.writeUInt16LE(0, 4); eocd.writeUInt16LE(0, 6);
  eocd.writeUInt16LE(names.length, 8); eocd.writeUInt16LE(names.length, 10);
  eocd.writeUInt32LE(cd.length, 12); eocd.writeUInt32LE(offset, 16); eocd.writeUInt16LE(0, 20);
  return Buffer.concat([...locals, cd, eocd]);
}

// ---- 主流程 ----
if (!fs.existsSync(path.join(PACK, 'pack.mcmeta'))) { console.error('❌ 找不到 ' + PACK + '/pack.mcmeta —— 包体目录不对？'); process.exit(1); }
const names = collect();
const zip = buildZip(names);
const sha = crypto.createHash('sha256').update(zip).digest('hex');
const target = path.join(DIST, NAME);

if (CHECK) {
  if (!fs.existsSync(target)) { console.error('❌ dist/ 里没有 ' + NAME + ' —— 先跑一次不带 --check 的。'); process.exit(1); }
  const cur = fs.readFileSync(target);
  const curSha = crypto.createHash('sha256').update(cur).digest('hex');
  const same = cur.equals(zip);
  console.log('条目 ' + names.length + ' 个（' + names.filter((n) => !n.endsWith('/')).length + ' 文件）· 重新打包 ' + zip.length + ' B · 现存 ' + cur.length + ' B');
  console.log('重新打包 sha256 ' + sha);
  console.log('dist 现存  sha256 ' + curSha);
  console.log(same ? '✅ 逐字节一致（0 差异）' : '❌ 不一致 —— dist 里的 zip 不是这份包体打的');
  process.exit(same ? 0 : 1);
}

fs.mkdirSync(DIST, { recursive: true });
fs.writeFileSync(target, zip);
fs.writeFileSync(path.join(DIST, 'SHA256SUMS.txt'), sha + '  ' + NAME + '\n');
console.log('✅ 写出 dist/' + NAME + '（' + zip.length + ' B · ' + names.filter((n) => !n.endsWith('/')).length + ' 文件）');
console.log('   sha256 ' + sha);
