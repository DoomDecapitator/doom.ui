$bossbar add doom.ui:bb_$(sid) bossbar
$bossbar set doom.ui:bb_$(sid) name {"nbt":"_.name","storage":"doom.ui:ctx","interpret":true}
function doom.ui:internal/bossbar/apply_players with storage doom.ui:ctx _
$bossbar set doom.ui:bb_$(sid) color $(color)
$bossbar set doom.ui:bb_$(sid) style $(style)
$bossbar set doom.ui:bb_$(sid) max $(time)
$bossbar set doom.ui:bb_$(sid) value $(time)
$data modify storage doom.ui:ctx sessions.bb_$(sid) set value {}
$data modify storage doom.ui:ctx sessions.bb_$(sid).on_fade set from storage doom.ui:ctx _.on_fade
$data modify storage doom.ui:ctx sessions.bb_$(sid).name set from storage doom.ui:ctx _.name
$data modify storage doom.ui:ctx sessions.bb_$(sid).bid set from storage doom.ui:ctx _.bid
$data modify storage doom.ui:ctx sessions.bb_$(sid).show_sec set from storage doom.ui:ctx _.show_sec
$data modify storage doom.ui:ctx sessions.bb_$(sid).sep set from storage doom.ui:ctx _.sep
$data modify storage doom.ui:ctx sessions.bb_$(sid).on_interrupt set from storage doom.ui:ctx _.on_interrupt
$data modify storage doom.ui:ctx sessions.bb_$(sid).on_interrupted_run set from storage doom.ui:ctx _.on_interrupted_run
$data modify storage doom.ui:ctx sessions.bb_$(sid).time set value $(time)
$data modify storage doom.ui:ctx active_bossbars append value {sid: $(sid)}