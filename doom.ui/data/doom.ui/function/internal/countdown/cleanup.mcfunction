# doom.ui:internal/countdown/cleanup -- cleanup expired entries
$data modify storage doom.ui:ctx _.id set value "dt.cd_$(slot)"
function doom.ui:internal/mixer/remove_segment with storage doom.ui:ctx _
$data remove storage doom.ui:ctx sessions.cd_$(uid)[{slot:"$(slot)"}]

