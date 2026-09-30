# doom.ui:internal/actionbar/ab_clear -- clear actionbar by slot
execute store result storage doom.ui:ctx _.uid int 1 run scoreboard players get @s dt.uid
function doom.ui:internal/actionbar/ab_clear_impl with storage doom.ui:ctx _
