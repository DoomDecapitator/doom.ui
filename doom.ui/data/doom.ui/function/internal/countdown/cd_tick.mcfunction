# doom.ui:internal/countdown/cd_tick -- tick countdown per player
execute store result storage doom.ui:ctx _.uid int 1 run scoreboard players get @s dt.uid
execute if data storage doom.ui:ctx _.uid run function doom.ui:internal/countdown/cd_tick_player with storage doom.ui:ctx _
