# doom.ui:internal/xpbar/restore_macro -- restore xpbar via macro
data remove storage doom.ui:ctx _.temp.on_fade
$data modify storage doom.ui:ctx _.temp.on_fade set from storage doom.ui:ctx sessions.xp_$(old_sid).on_fade
execute if data storage doom.ui:ctx _.temp.on_fade if score @s dt.xp_time matches ..0 run function doom.ui:internal/exec_on_fade with storage doom.ui:ctx _.temp
$data remove storage doom.ui:ctx sessions.xp_$(old_sid)
experience set @s 0 levels
experience set @s 0 points
$experience set @s $(lvl) levels
$experience set @s $(pts) points
scoreboard players reset @s dt.sid_xp
