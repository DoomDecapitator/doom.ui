// src/tools/check_static.mjs —— doom.ui 的离线静态门（不需要服务器、不需要 Java、<2s）。
//
//   node src/tools/check_static.mjs [--vscode]
//
// 包体入口：<仓库根>/doom.ui/（本文件在 <仓库根>/src/tools/）；用 DOOM_PACK 指到别处即可查别的克隆。
//
// 规则来源：与 doom.nats 的 `tools/lint_ctm.mjs`（L1–L14）同源，只保留与包无关、真机验证过的那些
// （每一条都对应一次真机「Failed to load function」；mcfunction 是加载期解析，一条脏命令 ⇒ 整个函数消失）。
//
//   E-JSON  .json 不能解析 / pack.mcmeta 不合法
//   L1      函数与 `#tag` 引用必须存在（外部命名空间如 doom.schedule 只提示不报错）
//   L4      含 $(...) 但没有 `$` 前缀（不会被替换 ⇒ 命令解析失败）
//   L7      占位符写成 ${name}（只认 $(name)）
//   L9      行尾注释（mcfunction 只允许整行 #）
//   L10     非法相对坐标 ~+N
//   L11     引号外连续两个空格（Brigadier 报 Incorrect argument）
//   L12     宏行（`$` 开头）里没有任何 $(name) ⇒ No variables in macro
//   L13     裸 undefined / NaN（模板把 JS 值漏进命令 ⇒ Expected integer）
//   W-WITH  宏文件既没有自己的 `with`，也没有任何调用方用 `with`（warning：可能是死宏，也可能是漏参数）
//
// 输出：--vscode ⇒ `相对路径:行:列: error|warning: 消息`（配 tasks.json 的 $gcc problemMatcher）；
//       否则人类可读。退出码 = 有 error 则 1，便于直接接 CI。
import fs from 'node:fs';
import path from 'node:path';
import { fileURLToPath } from 'node:url';

const TOOL = path.dirname(fileURLToPath(import.meta.url));
const ROOT = path.resolve(TOOL, '..', '..');
// 包体入口：<仓库根>/doom.ui/（本文件在 <仓库根>/src/tools/）；DOOM_PACK 可指到别的克隆
const PACK = process.env.DOOM_PACK ? path.resolve(process.env.DOOM_PACK) : path.join(ROOT, 'doom.ui');
const argv = process.argv.slice(2);
const VSCODE = argv.includes('--vscode');
const LF = /\r?\n/;

const diags = [];
const add = (sev, file, line, msg) => diags.push({ file, line: line || 1, col: 1, sev, msg });

function walk(dir, out = []) {
  let ents = [];
  try { ents = fs.readdirSync(dir, { withFileTypes: true }); } catch { return out; }
  for (const e of ents) {
    const p = path.join(dir, e.name);
    if (e.isDirectory()) walk(p, out);
    else out.push(p);
  }
  return out;
}

const all = walk(PACK);
const rel = (p) => path.relative(PACK, p).split(path.sep).join('/');

// ---- ① JSON / pack.mcmeta ----
for (const p of all) {
  if (!p.endsWith('.json')) continue;
  try { JSON.parse(fs.readFileSync(p, 'utf8')); }
  catch (e) { add('ERROR', rel(p), 1, 'JSON 解析失败：' + e.message); }
}
const mcmetaPath = path.join(PACK, 'pack.mcmeta');
if (!fs.existsSync(mcmetaPath)) add('ERROR', 'pack.mcmeta', 1, '缺少 pack.mcmeta');
else {
  try {
    const m = JSON.parse(fs.readFileSync(mcmetaPath, 'utf8'));
    if (!m || !m.pack || !Number.isInteger(m.pack.pack_format)) add('ERROR', 'pack.mcmeta', 1, 'pack.pack_format 必须是整数');
    if (m && m.pack && !m.pack.description) add('ERROR', 'pack.mcmeta', 1, 'pack.description 缺失（游戏内列表会显示空白）');
  } catch { /* ① 已报 */ }
}

// ---- 收集定义 ----
const fns = new Set();
const fnTags = new Set();
for (const p of all) {
  const r = rel(p);
  let m = /^data\/([^/]+)\/function\/(.+)\.mcfunction$/.exec(r);
  if (m) { fns.add(m[1] + ':' + m[2]); continue; }
  m = /^data\/([^/]+)\/tags\/function\/(.+)\.json$/.exec(r);
  if (m) { fnTags.add(m[1] + ':' + m[2].replace(/\.json$/, '')); }
}

// ---- ② 逐行规则 ----
const macroCalled = new Set();     // 被 `function X with …` 调用的函数（宏调用点）
const fileHasWith = new Set();     // 文件自身含 `with storage/entity`
const definedNs = new Set([...fns, ...fnTags].map((s) => s.split(':')[0]));
const extWarned = new Set();

for (const p of all) {
  if (!p.endsWith('.mcfunction')) continue;
  const r = rel(p);
  const lines = fs.readFileSync(p, 'utf8').split(LF);
  lines.forEach((raw, i) => {
    const n = i + 1;
    const line = raw.trim();
    const body = line.startsWith('$') ? line.slice(1).trim() : line;
    if (!body || body.startsWith('#')) return;

    if (/\bwith\s+(storage|entity)\b/.test(body)) fileHasWith.add(r);

    // L4
    if (!line.startsWith('$') && body.includes('$(')) add('ERROR', r, n, '含 $(...) 但缺 `$` 前缀：' + body.slice(0, 60));
    // L7
    const bad = /\$\{[A-Za-z0-9_]+\}/.exec(line);
    if (bad) add(line.startsWith('$') ? 'ERROR' : 'WARN', r, n, '占位符写成 ' + bad[0] + '（应为 $(' + bad[0].slice(2, -1) + ')）');
    // L9（`#` 后跟空白的才是注释；`#ns:path` 与假玩家 `#name` 合法）
    if (/\s#\s/.test(line) && !line.startsWith('#')) add('ERROR', r, n, '行尾注释（mcfunction 只允许整行 # 注释）：' + line.slice(0, 60));
    // L10
    if (/~\+/.test(line)) add('ERROR', r, n, '非法相对坐标 ~+N：' + line.slice(0, 60));
    // L11（引号之外的连续空格）
    const unquoted = body.replace(/"(?:\\.|[^"\\])*"/g, '""').replace(/'(?:\\.|[^'\\])*'/g, "''");
    if (/[^ ] {2,}[^ ]/.test(unquoted)) add('ERROR', r, n, '命令含连续两个空格（Brigadier 会拒绝整条命令）：' + body.slice(0, 60));
    // L12
    if (line.startsWith('$') && !/\$\([A-Za-z0-9_]+(?::[A-Za-z0-9_]+)?\)/.test(line)) {
      add('ERROR', r, n, '宏行（$ 开头）里没有任何 $(name) 占位符，会导致整函数加载失败：' + line.slice(0, 60));
    }
    // L13
    if (/(?:^|\s)(undefined|NaN)(?:\s|$)/.test(body)) {
      add('ERROR', r, n, '产物里出现裸 ' + /(?:^|\s)(undefined|NaN)(?:\s|$)/.exec(body)[1] + '（整函数加载失败）：' + body.slice(0, 70));
    }
    // L1 函数引用（含宏调用点：`with storage/entity …` 与 1.20.2+ 的内联 `function ns:x {…}`）
    for (const mm of body.matchAll(/function\s+([a-z0-9_.-]+):([a-z0-9_/.-]*)(\s*(\{|with\b))?/g)) {
      const id = mm[1] + ':' + mm[2];
      if (mm[4]) macroCalled.add(id);
      if (fns.has(id)) continue;
      if (!definedNs.has(mm[1])) { if (!extWarned.has(mm[1])) { extWarned.add(mm[1]); add('WARN', r, n, '引用了外部命名空间 ' + mm[1] + ':（依赖包，不算错误）'); } continue; }
      // 允许前缀派发：ns:post/<slug> 这类由宏拼出
      if ([...fns].some((f) => f.startsWith(id))) continue;
      add('ERROR', r, n, '引用了不存在的函数 ' + id);
    }
    // L1 tag 引用
    for (const mm of body.matchAll(/function\s+#([a-z0-9_.-]+):([a-z0-9_/.-]+)/g)) {
      const id = mm[1] + ':' + mm[2];
      if (fnTags.has(id)) continue;
      if (!definedNs.has(mm[1])) continue;
      add('WARN', r, n, '引用了不存在的函数标签 #' + id);
    }
  });
}

// ---- ③ W-WITH：宏文件没有任何 with 来源 ----
for (const p of all) {
  if (!p.endsWith('.mcfunction')) continue;
  const r = rel(p);
  const id = /^data\/([^/]+)\/function\/(.+)\.mcfunction$/.exec(r);
  if (!id) continue;
  const full = id[1] + ':' + id[2];
  const hasMacroLine = fs.readFileSync(p, 'utf8').split(LF).some((l) => l.startsWith('$'));
  if (!hasMacroLine) continue;
  if (fileHasWith.has(r) || macroCalled.has(full)) continue;
  add('WARN', r, 1, '文件含宏行，但自身没有 `with`、也没有任何调用方用 `with`（多余宏或漏参数）');
}

// ---- 输出 ----
const errs = diags.filter((d) => d.sev === 'ERROR');
if (VSCODE) for (const d of diags) console.log(`${d.file}:${d.line}:${d.col}: ${d.sev === 'ERROR' ? 'error' : 'warning'}: ${d.msg}`);
else {
  console.log('=== doom.ui 静态检查（JSON / 引用闭包 / L4·L7·L9–L13 / 宏来源）===');
  for (const d of diags) console.log((d.sev === 'ERROR' ? '❌ ' : '⚠️  ') + d.file + ':' + d.line + ' ' + d.msg);
  if (!diags.length) console.log('✅ 全部通过（0 error · 0 warning）');
}
console.log((VSCODE ? '' : '结论: ') + errs.length + ' error, ' + (diags.length - errs.length) + ' warning');
process.exit(errs.length ? 1 : 0);
