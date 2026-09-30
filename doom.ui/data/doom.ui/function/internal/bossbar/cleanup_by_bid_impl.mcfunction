# doom.ui:internal/bossbar/cleanup_by_bid_impl -- cleanup by bid implementation (FIXED: read on_interrupted_run)
# 注：每条 on_* 前都先 data remove —— set from 的源不存在时不写入，留着旧值会触发陈旧回调
data remove storage doom.ui:ctx _.temp.on_fade
$data modify storage doom.ui:ctx _.temp.on_fade set from storage doom.ui:ctx sessions.bb_$(sid).on_fade
data remove storage doom.ui:ctx _.temp.on_interrupt
data remove storage doom.ui:ctx _.temp.on_interrupt
$data modify storage doom.ui:ctx _.temp.on_interrupt set from storage doom.ui:ctx sessions.bb_$(sid).on_interrupt
data remove storage doom.ui:ctx _.temp.on_interrupted_run
$data modify storage doom.ui:ctx _.temp.on_interrupted_run set from storage doom.ui:ctx sessions.bb_$(sid).on_interrupted_run
execute if data storage doom.ui:ctx _.temp.on_interrupted_run run function doom.ui:internal/exec_on_interrupted_run with storage doom.ui:ctx _.temp
execute unless data storage doom.ui:ctx _.temp.on_interrupted_run if data storage doom.ui:ctx _.temp.on_interrupt if data storage doom.ui:ctx _.temp.on_fade run function doom.ui:internal/exec_on_fade with storage doom.ui:ctx _.temp
$function doom.ui:internal/bossbar/cleanup {sid: $(sid), bid: "$(bid)"}
