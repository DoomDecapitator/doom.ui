# doom.ui:internal/xpbar/restore -- restore xpbar after death
execute store result storage doom.ui:ctx _.old_sid int 1 run scoreboard players get @s dt.sid_xp
execute store result storage doom.ui:ctx _.lvl int 1 run scoreboard players get @s dt.xp_lvl
execute store result storage doom.ui:ctx _.pts int 1 run scoreboard players get @s dt.xp_pts
function doom.ui:internal/xpbar/restore_macro with storage doom.ui:ctx _


