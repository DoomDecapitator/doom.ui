# doom.ui:internal/flash/toggle_macro -- toggle flash macro
$execute unless data storage doom.ui:ctx sessions.fl_$(sid) run return 0
$data modify storage doom.ui:ctx _.sid set value $(sid)
$execute as @a[scores={dt.sid_fl=$(sid)}] at @s run function doom.ui:internal/flash/toggle_impl with storage doom.ui:ctx _
$execute if data storage doom.ui:ctx sessions.fl_$(sid) run function #doom.schedule:schedule {run: "function doom.ui:internal/flash/toggle_macro {sid: $(sid), interval: $(interval)}", time: $(interval), id: "dt.fl_$(sid)", unit: "t"}