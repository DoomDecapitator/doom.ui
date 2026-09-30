# 变更日志 · doom.ui

> **口径**：namespace `doom.ui`（基于 `doom.schedule` 的 SID 会话管理 UI 框架）。
> 目标环境 **Minecraft 1.21.6 · Fabric**；`pack_format` 81，`supported_formats` 48–82；当前版本 **v2.0-beta**（GitHub 预发布）。
> 机器断言（55 用例 / 340 断言）跑在**私有开发仓库**的真机验收台里；本仓库保留的是人工观感清单
> [`docs/03-示例调用串.md`](docs/03-示例调用串.md) 与可切跑的三道门（`src/tools/`）。
>
> ⚠️ **全绿的读法**：F-7 / F-9 这类**发现项**在断言表里以「缺陷检出」形式登记（期望值 = 当前的缺陷行为），
> 所以 **55 PASS / 0 FAIL ≠ 这些已经修好**。未修项见下（F-9 ~ F-13；F-7 的复核结论另见 README）。

---

## 2026-09-29 · 仓库改版（本仓库结构）

- **顶层收到玩家向形态**：`README.md`（首屏四问）· `LICENSE` · `CHANGELOG.md` · `dist/` · `docs/`（玩家手册 5 篇）
  · **`doom.ui/`（数据包本体，每个 mcfunction 可直接点开）** · `src/`（门 + 打包）· `.github/ISSUE_TEMPLATE/`。
- **开发物移出**：`tests/`（真机验收台）· `reports/`（逐轮取证与日志）· `README_bossbar.md`（命名空间 `doom.bossbar`，
  **未随本包发布**）→ 私有开发仓库 `doom.ui-dev`；`tests/` `reports/` 从本仓库删除，不再随包分发。
  同时清掉一个 0 字节误建垃圾文件（shell 反引号事故的残余）。
- **发行 zip 修正了一处不同步**：`dist/doom.ui-v2.0-beta.zip` 原先停在 `971635c`，**落后于源码三个修复**
  （F-15 前缀取色 · F-16 `maxCommandChainLength` · F-17 原位改文本），并且里面混进了 `reports/`、`README*.md`、
  `测试文档.md` 这些**仓库文件**（165 条目 → 142 条目）。现按包体重打，并加了可复现门。
- **新增三道可切跑的门**（`src/tools/`）：`check_static.mjs`（原 `tools/` 的静态门，路径改到包体入口）·
  `check_leak.mjs`（泄漏 + 顶层白名单）· `make_dist.mjs`（确定性打包，`--check` 逐字节自证）。CI 三条一起跑。

## 2026-09-29 · 极限压测轮（F-14 ~ F-17）

- **F-16 命令链顶穿（真 bug，已修）**：6 台机器人 × 满槽时，countdown 每拍命令量顶穿 `maxCommandChainLength`（65536）
  ⇒ 服务器日志 **449 行** `Command execution stopped due to limit` ⇒ 会话条目被**静默丢弃**（实测 20 → 3~7）。
  修：新增 `internal/mixer/set_segment_quiet.mcfunction`（去掉每槽的 `build_title_arr` + `render_single`），
  并在 `__load__` 加 `gamerule maxCommandChainLength 2147483647`（双保险）。
  数字：P2 断言 **5/6 → 6/6**；日志增量 **+449 → 0**。
- **F-15 前缀取色（端侧发现，已修）**：countdown 的秒数与 `s` 不跟随前缀颜色 —— 实现读 `_.prefix.color`（**复合形态**），
  而 API 契约传的是**列表形态** ⇒ `data modify … set from` 静默失败 ⇒ 秒数一直默认白。
  修：两种形态都支持；新增回归用例 `cd_prefix_color`（红色槽 4 命中、无色槽 0 不命中）。
- **F-14「countdown 只保 17 槽」= 读数假象（不是包缺陷）**：RCON 的 `data get` 文本 **>≈4KB 会被截断/断连** ⇒ 读到 17。
  修的是测试台：`Srv.listLen` / `listField` + 不完备 SNBT 直接抛错 + 自动重连 + 改用计分板读长度。
- **F-17 同优先级原位改文本（性能清理，非解药）**：新增 `internal/mixer/update_text_in_place.mcfunction`，
  当 `#_f ≥ 1` 且 `#_f = #_p` 时只改 `.text` 再渲染（省掉 `count_higher` 的 20 次存储读 + 移除/插入）。
  40 人 countdown-only：**12.64 → 14.22 TPS**（≈ +1.6，仍在 ±1~2 噪声带内）。
  **真正的解药是 countdown 的原地 tick 重构**（记在开发仓库的待决项里）。
- **并发阶梯（空载机；每人 30 槽 ⇒ 900 个 UI 槽同时被驱动）**：

  | 人数 | 满载 TPS | 命令链截断 | 正确性 |
  |---|---|---|---|
  | 10 | **19.96** | 0 | 全绿 |
  | 20 | **19.99** | 0 | 全绿 |
  | 30 | **20.25** | 0 | 全绿 |
  | 40 | **≈12.4 – 13.9** | 0 | 全绿 |
  | 60 | **≈8.9** | 0 | 全绿 |

  拐点在 **20 与 40 之间**；同时全套用例（55 / 340 断言）在 30 人压测中 **55/0 · 340/0**。
- **画像（40 人逐步加，TPS 增量）**：countdown **−7.51** · bossbar −1.01 · actionbar −0.58 · xpbar 噪声（≈0）。
- **多玩家压测**：真机器人 3 台（6→8→9 台规模）/ P4 高频覆盖风暴 **300 轮 × 6 人 = 1800 次调用**（≈310 次/秒），
  断言不泄漏（`hot` 段始终 1 条）、会话不累积、风暴后 3 秒内 TPS 恢复 ≥19；全程 **19.9 – 20.2 TPS**。

## 2026-09-28 · 首轮真机验收（F-1 ~ F-13：11 项已修 / 6 项登记）

**已修（红→绿）**

- **F-1** ⭐ actionbar 的「到期 / 淡出 / `on_fade`」整条链**从未生效**（宏展开失败吞掉整个驱动）。
  - **F-1b** `if data` 判的是"存在" ⇒ `fade:false` 走错分支；**F-1c** 淡出结束时 `clear_macro` 必然早退 ⇒
    `on_fade` 丢失 + ■ 黑块永久残留；**F-1d** 同槽覆盖/清除时取消在飞的淡出链（否则旧链 ~12t 后回来摘掉**新建的同名槽**）。
- **F-2** bossbar 的 `bid` 索引在「到期」与「clear_all」两条路径上都泄漏（幽灵索引 → 幽灵会话）。
- **F-3** xpbar 经验公式三条分支不互斥（等级被顶飞、进度百分比是垃圾值）。
- **F-4** `silent_clear_all` 把玩家经验永久改坏（"静默" ≠ "损坏"）。
- **F-5** alert 的自然到期回调被 `on_interrupt` 门控（只给 `on_fade` 时永远不触发）。
- **F-6** `api/separator` 在玩家还没有 UI 会话时静默无效。

**已登记（未修，仍然存在）**

- **F-7** 第 11 槽（countdown 第 21 槽）被丢弃但 **mixer 段残留**（会话 10 条 vs 段 11 个）⇒ 残留段**永不到期**。
  建议在 `api/{actionbar,countdown}` 加槽位计数守卫（满则 `return 0`，不建段）。
  > **2026-09-29 复核**：`ab_slot_limit` / `cd_slot_limit` 两条用例现在都断言"无残留"并通过（段数分别 = 10 / 20）。
  > 也就是说**当前没有观察到残留**；若后续再出现，这两条会立刻变红。
- **F-8** README 写的「玩家离开/死亡自动清理」**不成立**：`tick` 用 `as @a[scores={dt.leave=1..}]` 分发，而离线的玩家
  **不在 `@a` 里** ⇒ `internal/player_leave` 不可达。现按**已知限制**处理：每人一条 `dt.uid` 残留（有界、无害），已被断言钉住。
  修法建议：反向扫描 `doom.ui:mixer data[].uid`，清理"没有在线玩家持有"的条目。
  > **2026-09-28 收口**：① 可达路径（重登后再离开）已在 `internal/player_leave` 补上 `dt.uid` 复位；
  > ② 离线回收 `internal/leave_scan`（每 20t）继续清 `sessions.*` 与 `doom.ui:mixer` 条目（真机断言 6/6 绿）；
  > ③ 契约与套件断言按"可达成"同步 —— 残留每人一条、有界无害。
- **F-9** 非法宏参数（如 `color:"orange"`）会留下**半截状态**：无 bossbar、无会话，但 `bb_index` 里已有幽灵条目。
  建议在 `api/bossbar` 里对 `color`/`style` 做白名单校验后再进 entry。
- **F-10** `clear type=3` 清 xpbar 时 `on_fade` 不触发（"结束回调"这条契约与实现不一致）。
- **F-11** flash 的 `on_fade` 在打断路径同样需要 `on_interrupt`（与 F-5 同源；是否统一取决于设计意图，待决）。
- **F-12** 非玩家实体（掉落物）会被分配 uid 并建立 UI 会话（`entry` 缺 `type=player` 过滤；玩家 UI 不受影响，但脏状态会累积）。
- **F-13** `silent_clear_all` 不取消已排定的延迟任务（到期时因会话已不存在而 no-op，但队列本身没清）。

**口径修正（都是实测换来的）**

- 非法 bossbar 颜色白名单：只认 `pink / blue / red / green / yellow / purple / white`（测试里曾用 `gold`/`aqua` ⇒ 假红）。
- **重门不得与轻门并发跑**：并发会让数字互相混写（实测两次假红：`verify_biome_at 3/0`、`verify_multibot 4/0`，单跑即复绿）。
- 面板 TPS 采样要固定窗口；`tellraw` 不进专用服务器日志 ⇒ 采集走 `say`。

## 2026-09-28 · v2.0-beta 首个预发布

- 发布 `README.md`（安装 / 依赖 / API 一览 / 限制）与 LICENSE；GitHub 预发布 **v2.0-beta**。
- **架构定稿**：每玩家 `dt.uid` 绑定 mixer 数据；UI 会话用 SID（`dt.sid_*`）标识；
  驱动循环（`#minecraft:tick`）countdown 20t / actionbar 5t / bossbar 1t / xpbar 1t；
  alert / flash 走 `doom.schedule` 的延迟执行；actionbar 经 mixer 按优先级（10–50）排序渲染。
- **规模**：122 个 mcfunction / 1632 行 / 86 个宏函数 / 4 个标签。
- **验收口径**：真机验收台（`--list` / `--only` / `--group`，退出码 0/1），
  首轮 **用例 52/53 · 断言 333/334**、服务器 TPS 19.9（1s 窗口）；人工观感清单见 [`docs/03-示例调用串.md`](docs/03-示例调用串.md)。

---

## 附：接口与边界（速查）

| 项 | 值 |
|---|---|
| 对外 API | `doom.ui:api/{actionbar,countdown,bossbar,alert,flash,chat,sound,separator,xpbar}` |
| 依赖 | `doom.schedule` v2+（alert / flash / actionbar 淡出的延迟回调） |
| 外部注册钩子 | `#doom.ui:interrupt` |
| 槽位上限 | actionbar **10** / countdown **20**（超限丢弃；段残留见 F-7） |
| 离线清理 | 不自动（**见 F-8**）：每人一条 `dt.uid` 残留，有界无害 |
| 三道门 | `node src/tools/check_static.mjs`（静态门）· `node src/tools/check_leak.mjs`（泄漏 + 顶层白名单）· `node src/tools/make_dist.mjs --check`（发行物可复现）；CI 见 `.github/workflows/static.yml` |
