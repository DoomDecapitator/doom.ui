# doom.ui:internal/silent_clear_player -- silent clear player without callbacks
# 2026-09-28 真机验收新增：先把 xpbar 期间被改写的经验还原（静默，不触发 on_fade）
execute store result score #_xp dt.temp run scoreboard players get @s dt.sid_xp
execute if score #_xp dt.temp matches 1.. store result storage doom.ui:ctx _.xp_restore.lvl int 1 run scoreboard players get @s dt.xp_lvl
execute if score #_xp dt.temp matches 1.. store result storage doom.ui:ctx _.xp_restore.pts int 1 run scoreboard players get @s dt.xp_pts
execute if score #_xp dt.temp matches 1.. run function doom.ui:internal/xpbar/silent_restore with storage doom.ui:ctx _.xp_restore
data remove storage doom.ui:ctx _.xp_restore
execute store result score #_uid dt.temp run scoreboard players get @s dt.uid
execute if score #_uid dt.temp matches 1.. run function doom.ui:internal/mixer/remove_player
scoreboard players reset @s dt.ab_remain
scoreboard players reset @s dt.sid_al
scoreboard players reset @s dt.sid_fl
scoreboard players reset @s dt.sid_xp
scoreboard players reset @s dt.fl_r
scoreboard players reset @s dt.xp_time
title @s reset
title @s clear
