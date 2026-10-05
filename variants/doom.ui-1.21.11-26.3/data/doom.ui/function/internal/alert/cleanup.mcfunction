$function doom.schedule:cancel_one {id:"dt.al_$(sid)"}
$data remove storage doom.ui:ctx sessions.al_$(sid)
execute if entity @s run scoreboard players reset @s dt.sid_al
execute if entity @s run title @s reset
execute if entity @s run title @s clear
