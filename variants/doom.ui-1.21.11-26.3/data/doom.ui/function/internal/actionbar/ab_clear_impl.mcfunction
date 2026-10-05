# doom.ui:internal/actionbar/ab_clear_impl -- clear actionbar implementation (slot via macro)
execute unless data storage doom.ui:ctx _.uid run return 0
$execute unless data storage doom.ui:ctx sessions.ab_$(uid)[{slot:"$(slot)"}] run return 0
$data modify storage doom.ui:ctx _.temp.on_fade set from storage doom.ui:ctx sessions.ab_$(uid)[{slot:"$(slot)"}].on_fade
execute if data storage doom.ui:ctx _.temp.on_fade run function doom.ui:internal/exec_on_fade with storage doom.ui:ctx _.temp
$function doom.ui:internal/actionbar/cleanup {uid: $(uid), slot: "$(slot)"}
# Re-render actionbar after clear
function doom.ui:internal/mixer/build_title_arr with storage doom.ui:ctx _
$execute as @a[scores={dt.uid=$(uid)}] run function doom.ui:internal/mixer/render_single {uid: $(uid)}
