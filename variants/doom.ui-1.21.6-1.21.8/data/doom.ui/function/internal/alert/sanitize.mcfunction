# doom.ui:internal/alert/sanitize -- 把 title times 的三段钳到合法范围
#
# 2026-09-28 源码依据（MC 1.21.6）：
#   · 服务端：TitleCommand 用 TimeArgument.time()（TimeArgument.java: minimum = 0）——
#     **负数直接是解析期错误**；alert/apply 是宏函数 ⇒ 一次负值让整次 alert 静默消失。
#   · 客户端：Gui.setTimes 也只接受 ≥ 0 的三段（`if (v >= 0)` 才生效）。
#   所以这里先把三段落成 int 分数、负数钳到 0、再写回 storage，apply 再用（快照在调用时取）。
# 调用方式：function doom.ui:internal/alert/sanitize with storage doom.ui:ctx _
execute store result score #_fi dt.temp run data get storage doom.ui:ctx _.fade_in
execute store result score #_tm dt.temp run data get storage doom.ui:ctx _.time
execute store result score #_fo dt.temp run data get storage doom.ui:ctx _.fade_out
execute if score #_fi dt.temp matches ..-1 run scoreboard players set #_fi dt.temp 0
execute if score #_tm dt.temp matches ..-1 run scoreboard players set #_tm dt.temp 0
execute if score #_fo dt.temp matches ..-1 run scoreboard players set #_fo dt.temp 0
execute store result storage doom.ui:ctx _.fade_in int 1 run scoreboard players get #_fi dt.temp
execute store result storage doom.ui:ctx _.time int 1 run scoreboard players get #_tm dt.temp
execute store result storage doom.ui:ctx _.fade_out int 1 run scoreboard players get #_fo dt.temp
