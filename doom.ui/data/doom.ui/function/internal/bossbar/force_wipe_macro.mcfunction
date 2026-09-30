# doom.ui:internal/bossbar/force_wipe_macro -- force wipe bossbar macro (FIXED: read order)
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
# 2026-09-28 真机验收修：bid 必须在删 sessions **之前**读取。
#   原顺序（先删 sessions.bb_<sid> 再读 .bid）永远读到空串 ⇒ drop_bid 只删掉 bb_index."" ，
#   真正的 bb_index."<bid>" 残留成**幽灵索引**：clear_all 之后再按旧 bid 调 bossbar_update，
#   会在已经销毁的 sid 上重建会话（update_impl 不校验存在性），屏幕上没有条、状态里却有一条会话。
data modify storage doom.ui:ctx _.bb_expire set value {bid:""}
$data modify storage doom.ui:ctx _.bb_expire.bid set from storage doom.ui:ctx sessions.bb_$(sid).bid
$bossbar remove doom.ui:bb_$(sid)
data remove storage doom.ui:ctx active_bossbars[0]
$data remove storage doom.ui:ctx sessions.bb_$(sid)
$data remove storage doom.ui:ctx bossbars[{sid:$(sid)}]
function doom.ui:internal/bossbar/drop_bid with storage doom.ui:ctx _.bb_expire
execute if data storage doom.ui:ctx active_bossbars[0] run function doom.ui:internal/bossbar/force_wipe_macro with storage doom.ui:ctx active_bossbars[0]
