# doom.ui:internal/xpbar/tick_macro -- tick xpbar display via macro
$execute unless data storage doom.ui:ctx sessions.xp_$(sid) run return 0

scoreboard players remove @s dt.xp_time 1

experience set @s 0 levels
$experience set @s $(lvl) levels

experience set @s 0 points
$experience add @s $(pts) points

execute if score @s dt.xp_time matches ..0 run function doom.ui:internal/xpbar/restore with storage doom.ui:ctx _


