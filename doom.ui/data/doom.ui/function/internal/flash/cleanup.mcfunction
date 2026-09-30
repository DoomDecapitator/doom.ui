$function doom.schedule:cancel_one {id:"dt.fl_$(sid)"}
$data remove storage doom.ui:ctx sessions.fl_$(sid)
execute if entity @s run scoreboard players reset @s dt.sid_fl
execute if entity @s run scoreboard players reset @s dt.fl_r
execute if entity @s run title @s reset
execute if entity @s run title @s clear
