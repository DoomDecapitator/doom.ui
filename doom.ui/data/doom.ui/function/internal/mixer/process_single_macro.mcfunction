# doom.ui:internal/mixer/process_single_macro -- process single mixer entry via macro (FIXED: player-specific)
function doom.ui:internal/mixer/build_title_arr with storage doom.ui:ctx _
$execute as @a[scores={dt.uid=$(uid)}] run function doom.ui:internal/mixer/render_single {uid: $(uid)}
