# doom.ui:internal/bossbar/replace_bid -- 同一 bid 重复创建时，静默移除旧条
# 调用方式：function doom.ui:internal/bossbar/replace_bid with storage doom.ui:ctx _
#   $(bid) 必须是**旧条**的 bid；本函数会把 _.sid 改写成旧 sid 再交给 cleanup。
#
# 为什么静默（不发 on_fade / on_interrupt）：
#   旧条既没有到期、也没有被外部打断，它只是被同名的新条**替换**了。
#   触发 on_fade 会让调用方收到一个语义上不存在的"结束"事件。
#
# 修复背景（2026-09-11 实测）：
#   entry 旧版不查重 —— 同一 bid 调两次会建出两条 bossbar，而 bb_index 只指向最新一条，
#   于是旧条既 update 不到也 remove 不掉，只能等它自然到期，玩家屏幕上同时出现两根条。
$data modify storage doom.ui:ctx _.sid set from storage doom.ui:ctx bb_index."$(bid)"
function doom.ui:internal/bossbar/cleanup with storage doom.ui:ctx _
