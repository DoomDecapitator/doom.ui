# doom.ui:internal/bossbar/cleanup_by_bid -- cleanup bossbar by bid
# sid 从 bb_index 直读（O(1) 映射）。先 remove，未命中时 _.sid 保持不存在，
# 避免 if data 对数值 0 判真的坑（探针 B1 实测：0 也判真，守卫必须用 score 比大小）。
data remove storage doom.ui:ctx _.sid
$data modify storage doom.ui:ctx _.sid set from storage doom.ui:ctx bb_index."$(bid)"
execute if data storage doom.ui:ctx _.sid run function doom.ui:internal/bossbar/cleanup_by_bid_impl with storage doom.ui:ctx _