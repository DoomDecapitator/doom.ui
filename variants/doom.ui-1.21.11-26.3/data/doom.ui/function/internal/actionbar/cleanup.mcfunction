# doom.ui:internal/actionbar/cleanup -- cleanup expired entries
# 2026-09-28 真机验收新增：本槽被「覆盖 / clear / remove」时，取消可能还在飞的淡出链。
#   否则旧链会在 ~12t 后回来执行 remove_segment + 旧 on_fade，把**新**的同名槽一起摘掉。
$function doom.schedule:cancel_all {id: 'dt.abf_$(uid)_$(slot)'}
$data modify storage doom.ui:ctx _.id set value "dt.ab_$(slot)"
function doom.ui:internal/mixer/remove_segment with storage doom.ui:ctx _
$data remove storage doom.ui:ctx sessions.ab_$(uid)[{slot:"$(slot)"}]
