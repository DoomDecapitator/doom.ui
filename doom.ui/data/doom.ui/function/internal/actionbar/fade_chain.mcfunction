# doom.ui:internal/actionbar/fade_chain -- progressive fade-out then cleanup (self-decrementing)
# FIXED: 多实例隔离
#   - 参数走 per-uid 存储 _.fade_next.<uid>（消除全局共享串扰）
#   - 续排改走 doom.schedule（2026-09-28 真机验收修）：原版 /schedule 既不能带宏参数
#     （`schedule function <fn> <time>`），也不能调度宏函数（`Can't schedule a macro`），
#     整条淡出链其实**从未启动**，而且失败发生在宏展开期 ⇒ 调用它的 ab_tick_slot 被整体放弃。
#   - 结束改调 fade_end（与会话解耦）：到期时 sessions 里已经没有该条目，
#     原 clear_macro 的 `unless data sessions…run return 0` 必然早退 ⇒ on_fade 丢失、■ 段永久残留。
#   - 每次执行: #step = $(step) - 1, 渲染, 若 >=0 则写回本 uid 路径并排下一拍
$scoreboard players set #step dt.temp $(step)
scoreboard players remove #step dt.temp 1
# Render dimmed placeholder (progressively darker)
data modify storage doom.ui:ctx _.text set value {text:"",extra:[{text:"■",color:"gray"}]}
execute if score #step dt.temp matches 3.. run data modify storage doom.ui:ctx _.text set value {text:"",extra:[{text:"■",color:"gray"}]}
execute if score #step dt.temp matches 1..2 run data modify storage doom.ui:ctx _.text set value {text:"",extra:[{text:"■",color:"dark_gray"}]}
execute if score #step dt.temp matches 0 run data modify storage doom.ui:ctx _.text set value {text:"",extra:[{text:"■",color:"black"}]}
$data modify storage doom.ui:ctx _.id set value "dt.ab_$(slot)"
$data modify storage doom.ui:ctx _.uid set value $(uid)
data modify storage doom.ui:ctx _.priority set value 50
execute if score #step dt.temp matches 0.. run function doom.ui:internal/mixer/set_segment with storage doom.ui:ctx _
# Continue fading: write per-uid storage slot, then hand the next beat to doom.schedule
$execute if score #step dt.temp matches 0.. run execute store result storage doom.ui:ctx _.fade_next.$(uid).step int 1 run scoreboard players get #step dt.temp
$execute if score #step dt.temp matches 0.. run function doom.ui:internal/actionbar/fade_schedule with storage doom.ui:ctx _.fade_next.$(uid)
# Done fading
$execute if score #step dt.temp matches ..-1 run function doom.ui:internal/actionbar/fade_end with storage doom.ui:ctx _.fade_next.$(uid)
