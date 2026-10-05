# doom.ui:internal/bossbar/update_impl -- update bossbar implementation
$execute store result score #old_val dt.temp run bossbar get doom.ui:bb_$(sid) value
$execute store result score #old_max dt.temp run bossbar get doom.ui:bb_$(sid) max
# 除零守卫：time:0 建的 bossbar max=0，不挡会报 Divide by zero
execute if score #old_max dt.temp matches ..0 run scoreboard players set #old_max dt.temp 1
$scoreboard players set #new_max dt.temp $(new_time)
scoreboard players operation #new_val dt.temp = #old_val dt.temp
scoreboard players operation #new_val dt.temp *= #new_max dt.temp
scoreboard players operation #new_val dt.temp /= #old_max dt.temp
$bossbar set doom.ui:bb_$(sid) max $(new_time)
$execute store result bossbar doom.ui:bb_$(sid) value run scoreboard players get #new_val dt.temp
$data modify storage doom.ui:ctx sessions.bb_$(sid).time set value $(new_time)