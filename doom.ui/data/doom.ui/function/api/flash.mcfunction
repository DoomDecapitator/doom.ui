data remove storage doom.ui:ctx _
$data modify storage doom.ui:ctx _ set value $(with)
execute unless data storage doom.ui:ctx _.targets run data modify storage doom.ui:ctx _.targets set value "@s"
execute unless data storage doom.ui:ctx _.count run data modify storage doom.ui:ctx _.count set value 5
execute unless data storage doom.ui:ctx _.interval run data modify storage doom.ui:ctx _.interval set value 10
execute unless data storage doom.ui:ctx _.title run data modify storage doom.ui:ctx _.title set value {text:""}
execute unless data storage doom.ui:ctx _.subtitle run data modify storage doom.ui:ctx _.subtitle set value {text:""}
function doom.ui:internal/flash/entry with storage doom.ui:ctx _


