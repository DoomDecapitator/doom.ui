# doom.ui:internal/bossbar/remove_dispatch -- 按 bid 移除
# 调用方式：function doom.ui:internal/bossbar/remove_dispatch with storage doom.ui:ctx _
# 命中判定走 bb_index 的普通路径，未命中即静默跳过。
$execute if data storage doom.ui:ctx bb_index."$(bid)" run function doom.ui:internal/bossbar/cleanup_by_bid with storage doom.ui:ctx _
