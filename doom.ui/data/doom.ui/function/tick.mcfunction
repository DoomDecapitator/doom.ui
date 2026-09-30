# doom.ui:tick -- main tick dispatch
execute if data storage doom.ui:ctx active_bossbars[0] run function doom.ui:internal/bossbar/bossbar_drive
execute if score #timer_20 dt.temp matches 20.. run scoreboard players set #timer_20 dt.temp 0
execute if score #timer_20 dt.temp matches 0 run function doom.ui:internal/countdown/cd_drive
# 2026-09-28 新增（F-8）：每 20t 回收「uid 没有在线持有者」的 mixer 条目与会话。
#   源码依据：leave_game 统计在 PlayerList.remove 的第一行授予，此时玩家已离开 @a（选择器只看在线实体），
#   所以下面第 12 行那条 `as @a[scores={dt.leave=1..}]` 永远选不到刚离开的人 —— 保留它（对"重登后再离开"无害），
#   真正的回收靠这一趟扫描。
execute if score #timer_20 dt.temp matches 0 run function doom.ui:internal/leave_scan
scoreboard players add #timer_20 dt.temp 1
execute if score #timer_5 dt.temp matches 5.. run scoreboard players set #timer_5 dt.temp 0
execute if score #timer_5 dt.temp matches 0 run function doom.ui:internal/actionbar/ab_drive
scoreboard players add #timer_5 dt.temp 1
function doom.ui:internal/xpbar/xpbar_drive
execute as @a[scores={dt.interrupt=1..}] run function #doom.ui:interrupt
scoreboard players set @a[scores={dt.interrupt=1..}] dt.interrupt 0
execute as @a[scores={dt.leave=1..}] run function doom.ui:internal/player_leave
execute as @a[scores={dt.deaths=1..}] run function doom.ui:internal/player_death
