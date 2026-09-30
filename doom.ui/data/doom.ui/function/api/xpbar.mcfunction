data remove storage doom.ui:ctx _
$data modify storage doom.ui:ctx _ set value $(with)
execute unless data storage doom.ui:ctx _.targets run data modify storage doom.ui:ctx _.targets set value "@s"
execute unless data storage doom.ui:ctx _.time run data modify storage doom.ui:ctx _.time set value 100
function doom.ui:internal/xpbar/entry with storage doom.ui:ctx _


