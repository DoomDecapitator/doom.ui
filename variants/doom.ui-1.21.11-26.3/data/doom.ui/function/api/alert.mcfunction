data remove storage doom.ui:ctx _
$data modify storage doom.ui:ctx _ set value $(with)
execute unless data storage doom.ui:ctx _.targets run data modify storage doom.ui:ctx _.targets set value "@s"
execute unless data storage doom.ui:ctx _.fade_in run data modify storage doom.ui:ctx _.fade_in set value 5
execute if data storage doom.ui:ctx _.stay run data modify storage doom.ui:ctx _.time set from storage doom.ui:ctx _.stay
execute unless data storage doom.ui:ctx _.time run data modify storage doom.ui:ctx _.time set value 100
execute unless data storage doom.ui:ctx _.fade_out run data modify storage doom.ui:ctx _.fade_out set value 10
execute unless data storage doom.ui:ctx _.title run data modify storage doom.ui:ctx _.title set value {text:""}
execute unless data storage doom.ui:ctx _.subtitle run data modify storage doom.ui:ctx _.subtitle set value {text:""}
# 2026-09-28：times 三段是 TimeArgument（最小值 0）⇒ 负数会让 alert/apply 整批实例化失败（静默消失）。
# 先钳到 ≥0 再进 entry（依据：TimeArgument.java minimum=0；客户端 Gui.setTimes 亦只接受 ≥0）。
function doom.ui:internal/alert/sanitize with storage doom.ui:ctx _
function doom.ui:internal/alert/entry with storage doom.ui:ctx _


