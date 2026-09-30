# doom.ui:internal/separator/apply -- apply settings to display
# 2026-09-28（F-12）：只剩玩家能走 UI 会话（entry 是 `execute as $(targets)`，不筛实体类型）
execute unless entity @s[type=minecraft:player] run return 0
# 2026-09-28 真机验收修（F-6）：先按需分配 uid（与 actionbar/countdown 的 assign 一致）。
# 旧版直接读 @s dt.uid：玩家还没有 UI 会话时 store result 写 0，
# 而 `if data _.uid` 对 0 也判真 ⇒ apply_impl 拿 uid=0 去写 mixer，分隔符落在**0 号假条目**上，
# 玩家的真实条目随后建立时又用回默认 " | "，表现为「api/separator 静默无效」。
execute unless score @s dt.uid matches 1.. run function doom.ui:internal/mixer/add_player
execute store result storage doom.ui:ctx _.uid int 1 run scoreboard players get @s dt.uid
execute if data storage doom.ui:ctx _.uid run function doom.ui:internal/separator/apply_impl with storage doom.ui:ctx _
