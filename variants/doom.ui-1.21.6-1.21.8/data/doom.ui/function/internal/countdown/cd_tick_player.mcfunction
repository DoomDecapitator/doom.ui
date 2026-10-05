# doom.ui:internal/countdown/cd_tick_player -- tick countdown player entry
$data modify storage doom.ui:ctx _.processing set from storage doom.ui:ctx sessions.cd_$(uid)
$data remove storage doom.ui:ctx sessions.cd_$(uid)
$data modify storage doom.ui:ctx sessions.cd_$(uid) set value []
# Copy each processing element to fixed path before processing
execute if data storage doom.ui:ctx _.processing[0] run data modify storage doom.ui:ctx _.slot_processing set from storage doom.ui:ctx _.processing[0]
execute if data storage doom.ui:ctx _.processing[0] run function doom.ui:internal/countdown/cd_tick_slot with storage doom.ui:ctx _.slot_processing
execute if data storage doom.ui:ctx _.processing[1] run data modify storage doom.ui:ctx _.slot_processing set from storage doom.ui:ctx _.processing[1]
execute if data storage doom.ui:ctx _.processing[1] run function doom.ui:internal/countdown/cd_tick_slot with storage doom.ui:ctx _.slot_processing
execute if data storage doom.ui:ctx _.processing[2] run data modify storage doom.ui:ctx _.slot_processing set from storage doom.ui:ctx _.processing[2]
execute if data storage doom.ui:ctx _.processing[2] run function doom.ui:internal/countdown/cd_tick_slot with storage doom.ui:ctx _.slot_processing
execute if data storage doom.ui:ctx _.processing[3] run data modify storage doom.ui:ctx _.slot_processing set from storage doom.ui:ctx _.processing[3]
execute if data storage doom.ui:ctx _.processing[3] run function doom.ui:internal/countdown/cd_tick_slot with storage doom.ui:ctx _.slot_processing
execute if data storage doom.ui:ctx _.processing[4] run data modify storage doom.ui:ctx _.slot_processing set from storage doom.ui:ctx _.processing[4]
execute if data storage doom.ui:ctx _.processing[4] run function doom.ui:internal/countdown/cd_tick_slot with storage doom.ui:ctx _.slot_processing
execute if data storage doom.ui:ctx _.processing[5] run data modify storage doom.ui:ctx _.slot_processing set from storage doom.ui:ctx _.processing[5]
execute if data storage doom.ui:ctx _.processing[5] run function doom.ui:internal/countdown/cd_tick_slot with storage doom.ui:ctx _.slot_processing
execute if data storage doom.ui:ctx _.processing[6] run data modify storage doom.ui:ctx _.slot_processing set from storage doom.ui:ctx _.processing[6]
execute if data storage doom.ui:ctx _.processing[6] run function doom.ui:internal/countdown/cd_tick_slot with storage doom.ui:ctx _.slot_processing
execute if data storage doom.ui:ctx _.processing[7] run data modify storage doom.ui:ctx _.slot_processing set from storage doom.ui:ctx _.processing[7]
execute if data storage doom.ui:ctx _.processing[7] run function doom.ui:internal/countdown/cd_tick_slot with storage doom.ui:ctx _.slot_processing
execute if data storage doom.ui:ctx _.processing[8] run data modify storage doom.ui:ctx _.slot_processing set from storage doom.ui:ctx _.processing[8]
execute if data storage doom.ui:ctx _.processing[8] run function doom.ui:internal/countdown/cd_tick_slot with storage doom.ui:ctx _.slot_processing
execute if data storage doom.ui:ctx _.processing[9] run data modify storage doom.ui:ctx _.slot_processing set from storage doom.ui:ctx _.processing[9]
execute if data storage doom.ui:ctx _.processing[9] run function doom.ui:internal/countdown/cd_tick_slot with storage doom.ui:ctx _.slot_processing
execute if data storage doom.ui:ctx _.processing[10] run data modify storage doom.ui:ctx _.slot_processing set from storage doom.ui:ctx _.processing[10]
execute if data storage doom.ui:ctx _.processing[10] run function doom.ui:internal/countdown/cd_tick_slot with storage doom.ui:ctx _.slot_processing
execute if data storage doom.ui:ctx _.processing[11] run data modify storage doom.ui:ctx _.slot_processing set from storage doom.ui:ctx _.processing[11]
execute if data storage doom.ui:ctx _.processing[11] run function doom.ui:internal/countdown/cd_tick_slot with storage doom.ui:ctx _.slot_processing
execute if data storage doom.ui:ctx _.processing[12] run data modify storage doom.ui:ctx _.slot_processing set from storage doom.ui:ctx _.processing[12]
execute if data storage doom.ui:ctx _.processing[12] run function doom.ui:internal/countdown/cd_tick_slot with storage doom.ui:ctx _.slot_processing
execute if data storage doom.ui:ctx _.processing[13] run data modify storage doom.ui:ctx _.slot_processing set from storage doom.ui:ctx _.processing[13]
execute if data storage doom.ui:ctx _.processing[13] run function doom.ui:internal/countdown/cd_tick_slot with storage doom.ui:ctx _.slot_processing
execute if data storage doom.ui:ctx _.processing[14] run data modify storage doom.ui:ctx _.slot_processing set from storage doom.ui:ctx _.processing[14]
execute if data storage doom.ui:ctx _.processing[14] run function doom.ui:internal/countdown/cd_tick_slot with storage doom.ui:ctx _.slot_processing
execute if data storage doom.ui:ctx _.processing[15] run data modify storage doom.ui:ctx _.slot_processing set from storage doom.ui:ctx _.processing[15]
execute if data storage doom.ui:ctx _.processing[15] run function doom.ui:internal/countdown/cd_tick_slot with storage doom.ui:ctx _.slot_processing
execute if data storage doom.ui:ctx _.processing[16] run data modify storage doom.ui:ctx _.slot_processing set from storage doom.ui:ctx _.processing[16]
execute if data storage doom.ui:ctx _.processing[16] run function doom.ui:internal/countdown/cd_tick_slot with storage doom.ui:ctx _.slot_processing
execute if data storage doom.ui:ctx _.processing[17] run data modify storage doom.ui:ctx _.slot_processing set from storage doom.ui:ctx _.processing[17]
execute if data storage doom.ui:ctx _.processing[17] run function doom.ui:internal/countdown/cd_tick_slot with storage doom.ui:ctx _.slot_processing
execute if data storage doom.ui:ctx _.processing[18] run data modify storage doom.ui:ctx _.slot_processing set from storage doom.ui:ctx _.processing[18]
execute if data storage doom.ui:ctx _.processing[18] run function doom.ui:internal/countdown/cd_tick_slot with storage doom.ui:ctx _.slot_processing
execute if data storage doom.ui:ctx _.processing[19] run data modify storage doom.ui:ctx _.slot_processing set from storage doom.ui:ctx _.processing[19]
execute if data storage doom.ui:ctx _.processing[19] run function doom.ui:internal/countdown/cd_tick_slot with storage doom.ui:ctx _.slot_processing
function doom.ui:internal/mixer/build_title_arr with storage doom.ui:ctx _
$execute as @a[scores={dt.uid=$(uid)}] run function doom.ui:internal/mixer/render_single {uid: $(uid)}
data remove storage doom.ui:ctx _.processing
data remove storage doom.ui:ctx _.slot_processing
