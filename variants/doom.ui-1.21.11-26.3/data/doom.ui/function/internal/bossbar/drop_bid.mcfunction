# doom.ui:internal/bossbar/drop_bid -- 从 bid → sid 映射里摘掉一项
# 调用方式：function doom.ui:internal/bossbar/drop_bid with storage doom.ui:ctx _.bb_expire
# 调用方必须先把 _.bb_expire.bid 初始化成 ""（缺失的 bid 会让 $(bid) 未定义并报宏错误）
$data remove storage doom.ui:ctx bb_index."$(bid)"
