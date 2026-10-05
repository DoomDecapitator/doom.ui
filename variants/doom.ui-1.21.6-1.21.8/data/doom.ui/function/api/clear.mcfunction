# doom.ui:api/clear -- clear UI by type (1=countdown, 2=actionbar, 3=player, 4=bossbar)
data remove storage doom.ui:ctx _
$data modify storage doom.ui:ctx _ set value $(with)
execute unless data storage doom.ui:ctx _.type run data modify storage doom.ui:ctx _.type set value 1
execute unless data storage doom.ui:ctx _.targets run data modify storage doom.ui:ctx _.targets set value "@s"
execute unless data storage doom.ui:ctx _.slot run data modify storage doom.ui:ctx _.slot set value "all"
execute store result score #_clear_type dt.temp run data get storage doom.ui:ctx _.type
# targets 不能在本函数用 $(targets)：宏快照在调用时取，这里只有 $(with)。
# 交给 dispatch，用 with storage 让 $(targets) 从 _.targets 解析。
function doom.ui:internal/clear/dispatch with storage doom.ui:ctx _
data remove storage doom.ui:ctx _
