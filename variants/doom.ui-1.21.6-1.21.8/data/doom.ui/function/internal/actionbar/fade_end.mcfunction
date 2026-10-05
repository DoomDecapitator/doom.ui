# doom.ui:internal/actionbar/fade_end -- 淡出结束：跑 on_fade，再摘掉本段
#
# 2026-09-28 真机验收新增。为什么不能沿用 clear_macro：
#   clear_macro 的第一步是 `unless data sessions.ab_<uid>[{slot}] run return 0`，
#   而 fade 的起点（ab_tick_slot 到期分支）**不会**把会话条目 append 回去 ——
#   也就是说淡出期间 sessions 里已经没有这条了 ⇒ clear_macro 必然早退，
#   on_fade 永不触发、mixer 里的 ■ 段永不摘除（黑块永久留在 actionbar 上）。
#   本函数只依赖 per-uid 存储 _.fade_next.<uid>（uid / slot / on_fade），与会话解耦。
#
# 自然到期（不是被 clear/remove 打断）⇒ on_fade 无条件执行，与 ab_tick_slot 的立即到期分支一致。
# 宏参数来自 _.fade_next.<uid>：uid / slot / step / (on_fade)
data remove storage doom.ui:ctx _.fade_end
data remove storage doom.ui:ctx _.fade_end.on_fade
$data modify storage doom.ui:ctx _.fade_end.on_fade set from storage doom.ui:ctx _.fade_next.$(uid).on_fade
execute if data storage doom.ui:ctx _.fade_end.on_fade run function doom.ui:internal/exec_on_fade with storage doom.ui:ctx _.fade_end
$data modify storage doom.ui:ctx _.id set value "dt.ab_$(slot)"
$data modify storage doom.ui:ctx _.uid set value $(uid)
function doom.ui:internal/mixer/remove_segment with storage doom.ui:ctx _
$data remove storage doom.ui:ctx _.fade_next.$(uid)
data remove storage doom.ui:ctx _.fade_end
