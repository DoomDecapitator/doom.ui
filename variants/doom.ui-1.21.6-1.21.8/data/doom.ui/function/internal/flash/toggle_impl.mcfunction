$execute unless data storage doom.ui:ctx sessions.fl_$(sid) run return 0
scoreboard players operation #parity dt.temp = @s dt.fl_r
scoreboard players set #2 dt.temp 2
scoreboard players operation #parity dt.temp %= #2 dt.temp
$data modify storage doom.ui:ctx _.temp_count set from storage doom.ui:ctx sessions.fl_$(sid).count
execute if score #parity dt.temp matches 0 if data storage doom.ui:ctx _.temp_count run execute store result score #wave dt.temp run data get storage doom.ui:ctx _.temp_count
execute if score #parity dt.temp matches 0 if data storage doom.ui:ctx _.temp_count run scoreboard players operation #wave dt.temp *= #2 dt.temp
execute if score #parity dt.temp matches 0 if data storage doom.ui:ctx _.temp_count run scoreboard players operation #wave dt.temp -= @s dt.fl_r
execute if score #parity dt.temp matches 0 if data storage doom.ui:ctx _.temp_count run scoreboard players set #2 dt.temp 2
execute if score #parity dt.temp matches 0 if data storage doom.ui:ctx _.temp_count run scoreboard players operation #wave dt.temp /= #2 dt.temp
execute if score #parity dt.temp matches 0 if data storage doom.ui:ctx _.temp_count run execute store result storage doom.ui:ctx _.wave int 1 run scoreboard players get #wave dt.temp
execute if score #parity dt.temp matches 0 if data storage doom.ui:ctx _.temp_count run function doom.ui:internal/flash/prepare_wave with storage doom.ui:ctx _
$execute if score #parity dt.temp matches 0 unless data storage doom.ui:ctx _.temp_count run data modify storage doom.ui:ctx _.title set from storage doom.ui:ctx sessions.fl_$(sid).title
$execute if score #parity dt.temp matches 0 unless data storage doom.ui:ctx _.temp_count run data modify storage doom.ui:ctx _.subtitle set from storage doom.ui:ctx sessions.fl_$(sid).subtitle
execute if score #parity dt.temp matches 0 unless data storage doom.ui:ctx _.temp_count run function doom.ui:internal/flash/toggle_show with storage doom.ui:ctx _
execute if score #parity dt.temp matches 1 run title @s clear
scoreboard players remove @s dt.fl_r 1
$data modify storage doom.ui:ctx _.temp.on_fade set from storage doom.ui:ctx sessions.fl_$(sid).on_fade
execute if score @s dt.fl_r matches ..0 if data storage doom.ui:ctx _.temp.on_fade run function doom.ui:internal/exec_on_fade with storage doom.ui:ctx _.temp
$execute if score @s dt.fl_r matches ..0 run function doom.ui:internal/flash/cleanup {sid: $(sid)}