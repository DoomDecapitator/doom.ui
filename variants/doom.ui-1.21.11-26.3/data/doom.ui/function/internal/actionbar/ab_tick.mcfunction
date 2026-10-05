# doom.ui:internal/actionbar/ab_tick -- tick actionbar per player
execute store result storage doom.ui:ctx _.uid int 1 run scoreboard players get @s dt.uid
execute if data storage doom.ui:ctx _.uid run function doom.ui:internal/actionbar/ab_tick_player with storage doom.ui:ctx _


