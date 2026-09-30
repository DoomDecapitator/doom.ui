# doom.ui:internal/leave_scan -- 回收「uid 没有在线持有者」的 mixer 条目与会话
#
# 2026-09-28 新增（F-8）。源码依据（MC 1.21.6）：
#   · PlayerList.remove(ServerPlayer) 第一件事就是 player.awardStat(Stats.LEAVE_GAME)（PlayerList.java:300），
#     而玩家随后就从 players 里摘除；`@a`/@s 这类实体选择器只看**在线**实体
#     ⇒ tick 里的 `execute as @a[scores={dt.leave=1..}]` 永远选不到刚离开的人（旧 internal/player_leave 不可达）。
#   · 反过来，mixer 的键是 uid（分数会为离线玩家保留）⇒ 只要「没有任何在线玩家持有这个 uid」，
#     就说明拥有者离线了，可以安全回收。这就是本函数的判据。
# 只回收会话与 mixer 条目；离线玩家的 dt.sid_*/dt.xp_time 分数无法用选择器 reset（记入已知限制）。
data modify storage doom.ui:ctx _.ls set from storage doom.ui:mixer data
execute if data storage doom.ui:ctx _.ls[0] run function doom.ui:internal/leave_scan_next
data remove storage doom.ui:ctx _.ls
