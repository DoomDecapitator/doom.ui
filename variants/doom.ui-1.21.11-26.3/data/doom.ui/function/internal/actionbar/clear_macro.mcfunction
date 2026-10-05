# doom.ui:internal/actionbar/clear_macro -- clear macro entry for slot
$execute unless data storage doom.ui:ctx sessions.ab_$(uid)[{slot:"$(slot)"}] run return 0
$data modify storage doom.ui:ctx _.temp.on_fade set from storage doom.ui:ctx sessions.ab_$(uid)[{slot:"$(slot)"}].on_fade
execute if data storage doom.ui:ctx _.temp.on_fade run function doom.ui:internal/exec_on_fade with storage doom.ui:ctx _.temp
$function doom.ui:internal/actionbar/cleanup {uid: $(uid), slot: "$(slot)"}
