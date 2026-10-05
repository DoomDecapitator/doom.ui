# doom.ui:api/bossbar_remove -- remove bossbar by bid
# 约定（与 README 一致）：function doom.ui:api/bossbar_remove {with:{bid:"default"}}
#   旧版是扁平 {bid:"..."} 且内部没有 $(with)，与全库其余 API 不一致。
data remove storage doom.ui:ctx _
$data modify storage doom.ui:ctx _ set value $(with)
execute unless data storage doom.ui:ctx _.bid run data modify storage doom.ui:ctx _.bid set value "default"
function doom.ui:internal/bossbar/remove_dispatch with storage doom.ui:ctx _
data remove storage doom.ui:ctx _
