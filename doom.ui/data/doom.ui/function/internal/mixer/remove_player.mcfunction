execute store result storage doom.ui:ctx _.uid int 1 run scoreboard players get @s dt.uid
function doom.ui:internal/mixer/remove_player_macro with storage doom.ui:ctx _
scoreboard players reset @s dt.uid

