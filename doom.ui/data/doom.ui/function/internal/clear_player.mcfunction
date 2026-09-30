# doom.ui:internal/clear_player -- clear player session from storage
execute store result score #_uid dt.temp run scoreboard players get @s dt.uid
execute if score #_uid dt.temp matches 1.. run execute store result storage doom.ui:ctx _.uid int 1 run scoreboard players get @s dt.uid
execute if score #_uid dt.temp matches 1.. run function doom.ui:internal/wipe_sessions with storage doom.ui:ctx _
execute if score #_uid dt.temp matches 1.. run function doom.ui:internal/clear_player_cd with storage doom.ui:ctx _
# if data 对 0 也判真 → 改 score 判定（sid_xp 不存在时不该走 restore）
execute store result score #_old dt.temp run scoreboard players get @s dt.sid_xp
execute if score #_old dt.temp matches 1.. run scoreboard players reset @s dt.xp_time
execute if score #_old dt.temp matches 1.. run function doom.ui:internal/xpbar/restore with storage doom.ui:ctx _
execute store result storage doom.ui:ctx _.sid int 1 run scoreboard players get @s dt.sid_al
execute if data storage doom.ui:ctx _.sid run function doom.ui:internal/alert/clear_macro with storage doom.ui:ctx _
execute store result storage doom.ui:ctx _.sid int 1 run scoreboard players get @s dt.sid_fl
execute if data storage doom.ui:ctx _.sid run function doom.ui:internal/flash/clear_macro with storage doom.ui:ctx _
scoreboard players reset @s dt.ab_remain
execute if score #_uid dt.temp matches 1.. run function doom.ui:internal/mixer/remove_player
title @s reset
title @s clear
