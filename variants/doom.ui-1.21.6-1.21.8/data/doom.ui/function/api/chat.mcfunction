data remove storage doom.ui:ctx _
$data modify storage doom.ui:ctx _ set value $(with)
execute unless data storage doom.ui:ctx _.targets run data modify storage doom.ui:ctx _.targets set value "@s"
execute unless data storage doom.ui:ctx _.content run data modify storage doom.ui:ctx _.content set value {"text":""}
function doom.ui:internal/chat/entry with storage doom.ui:ctx _


