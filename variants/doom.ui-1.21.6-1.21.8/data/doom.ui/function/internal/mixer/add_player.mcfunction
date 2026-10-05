scoreboard players add #session dt.id 1
scoreboard players operation @s dt.uid = #session dt.id
execute store result storage doom.ui:ctx _.uid int 1 run scoreboard players get @s dt.uid
function doom.ui:internal/mixer/add_player_macro with storage doom.ui:ctx _

