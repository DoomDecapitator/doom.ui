data remove storage doom.ui:ctx _
$data modify storage doom.ui:ctx _ set value $(with)
execute unless data storage doom.ui:ctx _.targets run data modify storage doom.ui:ctx _.targets set value "@s"
execute if data storage doom.ui:ctx _.seconds run data modify storage doom.ui:ctx _.time set from storage doom.ui:ctx _.seconds
execute unless data storage doom.ui:ctx _.time run data modify storage doom.ui:ctx _.time set value 100
execute unless data storage doom.ui:ctx _.slot run data modify storage doom.ui:ctx _.slot set value "countdown"
execute unless data storage doom.ui:ctx _.prefix run data modify storage doom.ui:ctx _.prefix set value {text:""}
execute unless data storage doom.ui:ctx _.priority run data modify storage doom.ui:ctx _.priority set value 20
function doom.ui:internal/countdown/entry with storage doom.ui:ctx _
