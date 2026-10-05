#   教训：同一段逻辑被复制到两个文件时，只修一处 = 没修。
# FIXED (2026-09-11)：计数改为 count_higher —— 与 set_segment 共用同一份实现，不再各写一份。
# doom.ui:internal/mixer/update_segment -- update existing segment (rebuild with correct priority position)
# FIXED (P-B): 不再 append 到末尾，remove 后按 priority 重新插入正确位置
# FIXED (P3): text 用 set from 复制（支持任意 NBT 类型）
# 说明: 移除旧段后重新计数插入位置（基于移除后的 content，避免旧段干扰）
$data remove storage doom.ui:mixer data[{uid:$(uid)}].content[{id:"$(id)"}]
# 重新统计 priority > 新 priority 的段数（移除后的 content）
# 统计 priority 严格大于新 priority 的段数 = 插入位置（基于**移除之后**的 content）
# ⚠ 这里曾经有一份**独立复制的**档位计数代码（用 data get 过滤器当匹配数）——
#   2026-09-11 修 set_segment 时漏了它。而 update_segment 是「段已存在」时走的路径，
#   也就是倒计时/actionbar 每个 tick 都会走的路径 → 实测段序错乱 + 段重复。
$data modify storage doom.ui:ctx _.scan set from storage doom.ui:mixer data[{uid:$(uid)}].content
function doom.ui:internal/mixer/count_higher with storage doom.ui:ctx _
data remove storage doom.ui:ctx _.scan
execute store result storage doom.ui:ctx _.ins int 1 run scoreboard players get #_ins dt.temp
$data modify storage doom.ui:mixer data[{uid:$(uid)}].content insert $(ins) value {id:"$(id)", priority:$(priority)}
$execute if data storage doom.ui:ctx _.text run data modify storage doom.ui:mixer data[{uid:$(uid)}].content[{id:"$(id)"}].text set from storage doom.ui:ctx _.text
