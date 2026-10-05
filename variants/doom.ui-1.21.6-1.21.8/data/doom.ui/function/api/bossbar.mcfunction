# doom.ui:api/bossbar -- create bossbar display
data remove storage doom.ui:ctx _
$data modify storage doom.ui:ctx _ set value $(with)
execute unless data storage doom.ui:ctx _.targets run data modify storage doom.ui:ctx _.targets set value "@s"
execute unless data storage doom.ui:ctx _.name run data modify storage doom.ui:ctx _.name set value {"text":"bossbar"}
execute if data storage doom.ui:ctx _.duration run data modify storage doom.ui:ctx _.time set from storage doom.ui:ctx _.duration
execute unless data storage doom.ui:ctx _.time run data modify storage doom.ui:ctx _.time set value 100
# time <= 0 兜底（2026-09-11 实测修复）
#   MC 的 `bossbar set <id> max <n>` 参数下限是 **1**。time=0 时下游 apply 里的
#   `$bossbar set … max $(time)` 会拿到非法参数，后果不是报错、而是**静默损坏**：
#     - bossbar 事件建出来了（[`bossbar remove` 能成功、说明确实存在）
#     - bb_index."bid" 也写了
#     - 但 sessions.bb_<sid> **从未登记** → bb_index 指向幽灵条目，之后所有按 sid
#       反查的逻辑（update / remove / cleanup / 过期回收）都在操作不存在的东西
#   这个损坏极难发现：`bossbar get` 对**不存在**的 bossbar 也返回 0（实测），
#   所以"读到 max=0"无法区分"真的是 0"和"根本不存在"。
#   与其在下游逐个兜底，不如在这里把 time<=0 与"未提供"同等对待。
execute store result score #_bt dt.temp run data get storage doom.ui:ctx _.time
execute if score #_bt dt.temp matches ..0 run data modify storage doom.ui:ctx _.time set value 100
execute unless data storage doom.ui:ctx _.color run data modify storage doom.ui:ctx _.color set value "white"
execute unless data storage doom.ui:ctx _.style run data modify storage doom.ui:ctx _.style set value "progress"
execute unless data storage doom.ui:ctx _.bid run data modify storage doom.ui:ctx _.bid set value "default"
scoreboard players set #_sc dt.temp 0
execute if data storage doom.ui:ctx _.countdown run scoreboard players set #_sc dt.temp 1
execute store result storage doom.ui:ctx _.show_sec int 1 run scoreboard players get #_sc dt.temp
execute unless data storage doom.ui:ctx _.sep run data modify storage doom.ui:ctx _.sep set value ": "
function doom.ui:internal/bossbar/entry_safe with storage doom.ui:ctx _


