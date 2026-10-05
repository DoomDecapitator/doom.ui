# doom.ui:internal/clear/clear_countdown_impl -- clear countdown implementation (per-player cd_$(uid))
# FIXED: 槽位从 10 个补到 20 个 —— cd_tick_player 支持 20 槽，旧版 10..19 槽的中断回调永不触发
$data modify storage doom.ui:ctx _.slots set from storage doom.ui:ctx sessions.cd_$(uid)
execute if data storage doom.ui:ctx _.slots[0] run function doom.ui:internal/clear/cd_interrupt_slot with storage doom.ui:ctx _.slots[0]
execute if data storage doom.ui:ctx _.slots[1] run function doom.ui:internal/clear/cd_interrupt_slot with storage doom.ui:ctx _.slots[1]
execute if data storage doom.ui:ctx _.slots[2] run function doom.ui:internal/clear/cd_interrupt_slot with storage doom.ui:ctx _.slots[2]
execute if data storage doom.ui:ctx _.slots[3] run function doom.ui:internal/clear/cd_interrupt_slot with storage doom.ui:ctx _.slots[3]
execute if data storage doom.ui:ctx _.slots[4] run function doom.ui:internal/clear/cd_interrupt_slot with storage doom.ui:ctx _.slots[4]
execute if data storage doom.ui:ctx _.slots[5] run function doom.ui:internal/clear/cd_interrupt_slot with storage doom.ui:ctx _.slots[5]
execute if data storage doom.ui:ctx _.slots[6] run function doom.ui:internal/clear/cd_interrupt_slot with storage doom.ui:ctx _.slots[6]
execute if data storage doom.ui:ctx _.slots[7] run function doom.ui:internal/clear/cd_interrupt_slot with storage doom.ui:ctx _.slots[7]
execute if data storage doom.ui:ctx _.slots[8] run function doom.ui:internal/clear/cd_interrupt_slot with storage doom.ui:ctx _.slots[8]
execute if data storage doom.ui:ctx _.slots[9] run function doom.ui:internal/clear/cd_interrupt_slot with storage doom.ui:ctx _.slots[9]
execute if data storage doom.ui:ctx _.slots[10] run function doom.ui:internal/clear/cd_interrupt_slot with storage doom.ui:ctx _.slots[10]
execute if data storage doom.ui:ctx _.slots[11] run function doom.ui:internal/clear/cd_interrupt_slot with storage doom.ui:ctx _.slots[11]
execute if data storage doom.ui:ctx _.slots[12] run function doom.ui:internal/clear/cd_interrupt_slot with storage doom.ui:ctx _.slots[12]
execute if data storage doom.ui:ctx _.slots[13] run function doom.ui:internal/clear/cd_interrupt_slot with storage doom.ui:ctx _.slots[13]
execute if data storage doom.ui:ctx _.slots[14] run function doom.ui:internal/clear/cd_interrupt_slot with storage doom.ui:ctx _.slots[14]
execute if data storage doom.ui:ctx _.slots[15] run function doom.ui:internal/clear/cd_interrupt_slot with storage doom.ui:ctx _.slots[15]
execute if data storage doom.ui:ctx _.slots[16] run function doom.ui:internal/clear/cd_interrupt_slot with storage doom.ui:ctx _.slots[16]
execute if data storage doom.ui:ctx _.slots[17] run function doom.ui:internal/clear/cd_interrupt_slot with storage doom.ui:ctx _.slots[17]
execute if data storage doom.ui:ctx _.slots[18] run function doom.ui:internal/clear/cd_interrupt_slot with storage doom.ui:ctx _.slots[18]
execute if data storage doom.ui:ctx _.slots[19] run function doom.ui:internal/clear/cd_interrupt_slot with storage doom.ui:ctx _.slots[19]
$data remove storage doom.ui:ctx sessions.cd_$(uid)
$data remove storage doom.ui:mixer data[{uid:$(uid)}].content[{type:"cd"}]
function doom.ui:internal/mixer/build_title_arr with storage doom.ui:ctx _
$function doom.ui:internal/mixer/render_single {uid: $(uid)}
