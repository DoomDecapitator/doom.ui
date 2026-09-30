# doom.ui:api/separator -- set separator style
data remove storage doom.ui:ctx _
$data modify storage doom.ui:ctx _ set value $(with)
execute unless data storage doom.ui:ctx _.targets run data modify storage doom.ui:ctx _.targets set value "@s"
execute unless data storage doom.ui:ctx _.separator run data modify storage doom.ui:ctx _.separator set value {text:"|"}
function doom.ui:internal/separator/entry with storage doom.ui:ctx _
