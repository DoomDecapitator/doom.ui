# doom.ui:internal/clear/clear_actionbar_impl -- clear actionbar implementation
# FIXED: 槽位从 6 个补到 10 个 —— ab_tick_player 支持 10 槽，旧版 6..9 槽的中断回调永不触发
$data modify storage doom.ui:ctx _.slots set from storage doom.ui:ctx sessions.ab_$(uid)
execute if data storage doom.ui:ctx _.slots[0] run function doom.ui:internal/clear/ab_interrupt_slot with storage doom.ui:ctx _.slots[0]
execute if data storage doom.ui:ctx _.slots[1] run function doom.ui:internal/clear/ab_interrupt_slot with storage doom.ui:ctx _.slots[1]
execute if data storage doom.ui:ctx _.slots[2] run function doom.ui:internal/clear/ab_interrupt_slot with storage doom.ui:ctx _.slots[2]
execute if data storage doom.ui:ctx _.slots[3] run function doom.ui:internal/clear/ab_interrupt_slot with storage doom.ui:ctx _.slots[3]
execute if data storage doom.ui:ctx _.slots[4] run function doom.ui:internal/clear/ab_interrupt_slot with storage doom.ui:ctx _.slots[4]
execute if data storage doom.ui:ctx _.slots[5] run function doom.ui:internal/clear/ab_interrupt_slot with storage doom.ui:ctx _.slots[5]
execute if data storage doom.ui:ctx _.slots[6] run function doom.ui:internal/clear/ab_interrupt_slot with storage doom.ui:ctx _.slots[6]
execute if data storage doom.ui:ctx _.slots[7] run function doom.ui:internal/clear/ab_interrupt_slot with storage doom.ui:ctx _.slots[7]
execute if data storage doom.ui:ctx _.slots[8] run function doom.ui:internal/clear/ab_interrupt_slot with storage doom.ui:ctx _.slots[8]
execute if data storage doom.ui:ctx _.slots[9] run function doom.ui:internal/clear/ab_interrupt_slot with storage doom.ui:ctx _.slots[9]
$data remove storage doom.ui:ctx sessions.ab_$(uid)
$data remove storage doom.ui:mixer data[{uid:$(uid)}].content[{type:"ab"}]
function doom.ui:internal/mixer/build_title_arr with storage doom.ui:ctx _
$function doom.ui:internal/mixer/render_single {uid: $(uid)}
