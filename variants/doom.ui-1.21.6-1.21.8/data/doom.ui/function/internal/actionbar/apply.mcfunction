# doom.ui:internal/actionbar/apply -- apply settings to display
# 2026-09-28 新增（F-7）：10 槽已满 ⇒ 直接丢弃本次请求（不建会话、不建 mixer 段）
function doom.ui:internal/actionbar/slot_count with storage doom.ui:ctx _
execute if score #_slots dt.temp matches 10.. run return 0
$execute unless data storage doom.ui:ctx sessions.ab_$(uid) run data modify storage doom.ui:ctx sessions.ab_$(uid) set value []
$data modify storage doom.ui:ctx _.temp set value {uid:$(uid), slot:"$(slot)", time:$(time)}
data modify storage doom.ui:ctx _.temp.on_fade set from storage doom.ui:ctx _.on_fade
data modify storage doom.ui:ctx _.temp.on_interrupt set from storage doom.ui:ctx _.on_interrupt
data modify storage doom.ui:ctx _.temp.on_interrupted_run set from storage doom.ui:ctx _.on_interrupted_run
data modify storage doom.ui:ctx _.temp.fade set from storage doom.ui:ctx _.fade
$data modify storage doom.ui:ctx sessions.ab_$(uid) append from storage doom.ui:ctx _.temp
$data modify storage doom.ui:ctx _.id set value "dt.ab_$(slot)"
execute unless data storage doom.ui:ctx _.priority run data modify storage doom.ui:ctx _.priority set value 50
data modify storage doom.ui:ctx _.text set from storage doom.ui:ctx _.content
function doom.ui:internal/mixer/set_segment with storage doom.ui:ctx _
$data modify storage doom.ui:mixer data[{uid:$(uid)}].content[{id:"dt.ab_$(slot)"}].type set value "ab"
