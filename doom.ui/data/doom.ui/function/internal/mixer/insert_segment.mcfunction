# doom.ui:internal/mixer/insert_segment -- insert segment at computed position
# FIXED (P3): text 用 set from 复制而非 $(text) 宏内嵌（string 类型会破坏 SNBT，现支持任意 NBT 类型）
execute store result storage doom.ui:ctx _.ins int 1 run scoreboard players get #_ins dt.temp
$data modify storage doom.ui:mixer data[{uid:$(uid)}].content insert $(ins) value {id:"$(id)", priority:$(priority)}
$execute if data storage doom.ui:ctx _.text run data modify storage doom.ui:mixer data[{uid:$(uid)}].content[{id:"$(id)"}].text set from storage doom.ui:ctx _.text
data remove storage doom.ui:ctx _.ins
