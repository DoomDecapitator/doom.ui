# doom.ui:internal/player_leave -- cleanup all UI state for leaving player
execute store result storage doom.ui:ctx _.uid int 1 run scoreboard players get @s dt.uid
execute if score @s dt.uid matches 1.. run function doom.ui:internal/wipe_sessions with storage doom.ui:ctx _
execute if score @s dt.uid matches 1.. run function doom.ui:internal/clear_player_cd with storage doom.ui:ctx _
execute if score @s dt.uid matches 1.. run function doom.ui:internal/mixer/remove_player_macro with storage doom.ui:ctx _
scoreboard players reset @s dt.sid_al
scoreboard players reset @s dt.sid_fl
scoreboard players reset @s dt.sid_xp
scoreboard players reset @s dt.xp_time
scoreboard players reset @s dt.fl_r
scoreboard players reset @s dt.ab_remain
scoreboard players reset @s dt.leave
# 2026-09-28（F-8 收口）：离开清理**必须把 dt.uid 也复位**，且只能在**这里**（玩家还在 @a 里）做。
#   背景：README「玩家离开/死亡自动清理」这条契约的真机断言（套件 leave_cleanup）要求离线后 dt.uid 无分；
#   原来唯一一句 `reset @s dt.uid` 在 internal/mixer/remove_player.mcfunction:3，而那条链按 uid 反查 @a 选人
#   ⇒ 玩家一离线就打不到 ⇒ dt.uid 永久残留（旧 uid 泄漏，重登虽会重新分配，但长跑服会攒垃圾分）。
#   位置纪律：必须排在上面三句 `if score @s dt.uid matches 1..` 之后（否则守卫先失效，sessions/cd/mixer 都清不掉）。
scoreboard players reset @s dt.uid
