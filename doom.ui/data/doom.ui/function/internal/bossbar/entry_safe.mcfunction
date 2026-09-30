# doom.ui:internal/bossbar/entry_safe -- 前置校验后再进 entry
#
# 2026-09-28 源码依据（MC 1.21.6 BossBarCommands.java）：
#   `bossbar set <id> color <色>` 的颜色是 **Commands.literal 枚举**（pink/blue/red/green/yellow/purple/white），
#   `style` 同理（progress/notched_6/10/12/20）。非法取值不是运行期失败，而是**解析期**失败；
#   而 apply 是宏函数（整批实例化）⇒ 一次非法取值让整个 apply 被静默放弃。
#   旧版把 entry（写 bb_index/bossbars/active_bossbars）放在 apply 之前 ⇒ 留下**幽灵注册表条目**
#   （实测 clear_all 之后 bb_index={bad:1}），随后 bossbar_update 会在死 sid 上重建会话。
#   这里在写注册表之前先查白名单：非法 ⇒ 整次 api/bossbar 干净地什么都不做。
# 宏参数来自 doom.ui:ctx _：color / style
$execute unless data storage doom.ui:ctx const.colors."$(color)" run return 0
$execute unless data storage doom.ui:ctx const.styles."$(style)" run return 0
function doom.ui:internal/bossbar/entry with storage doom.ui:ctx _
