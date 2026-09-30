# doom.ui:internal/mixer/remove_segment -- remove segment from mixer
$data remove storage doom.ui:mixer data[{uid:$(uid)}].content[{id:"$(id)"}]
function doom.ui:internal/mixer/build_title_arr with storage doom.ui:ctx _
$execute store result score #_c0 dt.temp run data get storage doom.ui:mixer data[{uid:$(uid)}].content[0].priority
$execute if score #_c0 dt.temp matches 1.. as @a[scores={dt.uid=$(uid)}] run function doom.ui:internal/mixer/render_single {uid: $(uid)}
$execute unless score #_c0 dt.temp matches 1.. as @a[scores={dt.uid=$(uid)}] run title @s actionbar ""
