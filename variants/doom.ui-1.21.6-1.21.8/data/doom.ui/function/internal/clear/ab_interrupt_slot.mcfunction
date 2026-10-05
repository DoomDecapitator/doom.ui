# doom.ui:internal/clear/ab_interrupt_slot -- interrupt actionbar slot (FIXED: execute callbacks)
# 注：每条 on_* 前都先 data remove —— set from 的源不存在时不写入，留着旧值会触发陈旧回调
data remove storage doom.ui:ctx _.on_interrupted_run
$data modify storage doom.ui:ctx _.on_interrupted_run set from storage doom.ui:ctx _.slots[{slot:"$(slot)"}].on_interrupted_run
data remove storage doom.ui:ctx _.on_fade
$data modify storage doom.ui:ctx _.on_fade set from storage doom.ui:ctx _.slots[{slot:"$(slot)"}].on_fade
data remove storage doom.ui:ctx _.on_interrupt
data remove storage doom.ui:ctx _.on_interrupt
$data modify storage doom.ui:ctx _.on_interrupt set from storage doom.ui:ctx _.slots[{slot:"$(slot)"}].on_interrupt
execute if data storage doom.ui:ctx _.on_interrupted_run run function doom.ui:internal/exec_on_interrupted_run with storage doom.ui:ctx _
execute unless data storage doom.ui:ctx _.on_interrupted_run if data storage doom.ui:ctx _.on_interrupt if data storage doom.ui:ctx _.on_fade run function doom.ui:internal/exec_on_fade with storage doom.ui:ctx _
