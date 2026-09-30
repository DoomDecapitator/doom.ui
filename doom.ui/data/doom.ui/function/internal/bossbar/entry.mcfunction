# doom.ui:internal/bossbar/entry
# FIXED (2026-09-11)：同一 bid 重复创建必须**替换**旧条。
#   bid 在设计上是句柄（bossbar_update / bossbar_remove 都按它操作），重复即叠加会让旧条
#   既 update 不到也 remove 不掉，只能等它自然到期。详见 replace_bid.mcfunction。
$execute if data storage doom.ui:ctx bb_index."$(bid)" run function doom.ui:internal/bossbar/replace_bid with storage doom.ui:ctx _
scoreboard players add #session dt.id 1
execute store result storage doom.ui:ctx _.sid int 1 run scoreboard players get #session dt.id
data modify storage doom.ui:ctx bossbars append value {}
data modify storage doom.ui:ctx bossbars[-1].bid set from storage doom.ui:ctx _.bid
data modify storage doom.ui:ctx bossbars[-1].sid set from storage doom.ui:ctx _.sid
# bid → sid 映射：供 cleanup_by_bid / bossbar_update 直读（O(1)）
#   订正（2026-09-11）：曾经这里写着「filter 写在 set from 源端会静默失败」——**该结论是错的**。
#   游戏内探针 A5 逐字复刻了旧写法 bossbars[{bid:'dt_y'}].sid，实测可用（got = 22）。
#   改用映射表是出于查找成本与歧义的考虑，不是因为 filter 有 bug。
$data modify storage doom.ui:ctx bb_index."$(bid)" set from storage doom.ui:ctx _.sid
function doom.ui:internal/bossbar/apply with storage doom.ui:ctx _