# doom.ui:api/actionbar -- actionbar API
# FIXED (M2): content 归一化 - list 自动包成 compound {text:"",extra:list}
#   约定: content 必须是 JSON 组件 (compound) 或 组件数组 (list)
#   string 需用户写 {text:"x"} (NBT 无法可靠区分 string/compound)
data remove storage doom.ui:ctx _
$data modify storage doom.ui:ctx _ set value $(with)
execute unless data storage doom.ui:ctx _.targets run data modify storage doom.ui:ctx _.targets set value "@s"
execute if data storage doom.ui:ctx _.duration run data modify storage doom.ui:ctx _.time set from storage doom.ui:ctx _.duration
execute unless data storage doom.ui:ctx _.time run data modify storage doom.ui:ctx _.time set value 100
execute unless data storage doom.ui:ctx _.slot run data modify storage doom.ui:ctx _.slot set value "default"
execute unless data storage doom.ui:ctx _.content run data modify storage doom.ui:ctx _.content set value {text:""}
execute unless data storage doom.ui:ctx _.fade run data modify storage doom.ui:ctx _.fade set value true
# list → {text:"",extra:list}
execute if data storage doom.ui:ctx _.content[0] run data modify storage doom.ui:ctx _.tmp_extra set from storage doom.ui:ctx _.content
execute if data storage doom.ui:ctx _.tmp_extra run data modify storage doom.ui:ctx _.content set value {text:"",extra:[]}
execute if data storage doom.ui:ctx _.tmp_extra run data modify storage doom.ui:ctx _.content.extra set from storage doom.ui:ctx _.tmp_extra
data remove storage doom.ui:ctx _.tmp_extra
function doom.ui:internal/actionbar/entry with storage doom.ui:ctx _
