# doom.ui:internal/bossbar/update_dispatch -- bid / new_time 均经 with storage 取
# 调用方式：function doom.ui:internal/bossbar/update_dispatch with storage doom.ui:ctx _
data remove storage doom.ui:ctx _.sid
$data modify storage doom.ui:ctx _.sid set from storage doom.ui:ctx bb_index."$(bid)"
execute store result score #_bb_sid dt.temp run data get storage doom.ui:ctx _.sid
execute if score #_bb_sid dt.temp matches 1.. run function doom.ui:internal/bossbar/update_impl with storage doom.ui:ctx _
