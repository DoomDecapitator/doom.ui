data remove storage doom.ui:ctx _
$data modify storage doom.ui:ctx _ set value $(with)
execute unless data storage doom.ui:ctx _.targets run data modify storage doom.ui:ctx _.targets set value "@s"
execute unless data storage doom.ui:ctx _.slot run data modify storage doom.ui:ctx _.slot set value "default"
function doom.ui:internal/remove/entry with storage doom.ui:ctx _


