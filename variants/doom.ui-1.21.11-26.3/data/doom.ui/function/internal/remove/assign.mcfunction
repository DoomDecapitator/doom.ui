execute store result storage doom.ui:ctx _.uid int 1 run scoreboard players get @s dt.uid
execute if data storage doom.ui:ctx _.uid run function doom.ui:internal/remove/apply with storage doom.ui:ctx _

