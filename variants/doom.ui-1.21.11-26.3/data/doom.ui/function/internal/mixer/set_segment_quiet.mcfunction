# doom.ui:internal/mixer/set_segment_quiet —— 与 set_segment 完全一致，但**不做**每槽的 build_title_arr + render_single。
# 为什么：F-16（2026-09-29）。tick 路径（countdown 每槽一次）里 set_segment 的渲染是**冗余**的——
#   cd_tick_player / ab_tick_player 在循环结束后各自会 build+render 一次；每槽都渲一次会让
#   「玩家数 × 槽位数 × 每人每槽 ~190 条命令」直接顶穿 maxCommandChainLength(65536)，
#   服务端日志出现 `Command execution stopped due to limit`，**本拍的会话回写被静默截断** ⇒ 槽位凭空消失。
# doom.ui:internal/mixer/set_segment -- set segment in mixer
# FIXED (P-C): 档位扩展到 10/20/30/40/50/60/70/80/90/100（覆盖 10..100）
# 语义: priority 越高越靠前; 同 priority 新段插旧段之后 (FIFO 稳定)

#   旧版拿 data get 的过滤器当匹配数用，实测它返回的是 tag 大小 → 低优先级段会排错位置。
# FIXED (2026-09-11)：插入位置改为逐元素比对（count_higher）。
execute unless data storage doom.ui:mixer data run data modify storage doom.ui:mixer data set value []
scoreboard players set #_ex dt.temp 0
$execute store result score #_ex dt.temp run data get storage doom.ui:mixer data[{uid:$(uid)}].uid
execute if score #_ex dt.temp matches 0 run function doom.ui:internal/mixer/add_entry with storage doom.ui:ctx _
scoreboard players set #_f dt.temp 0
$execute store result score #_f dt.temp run data get storage doom.ui:mixer data[{uid:$(uid)}].content[{id:"$(id)"}].priority
$scoreboard players set #_p dt.temp $(priority)

# 统计 priority 严格大于新 priority 的段数 = 插入位置
# ⚠ 不能用 data get 的过滤器计数（实测返回的是 tag 大小，不是匹配数 → 探针 A8）
$data modify storage doom.ui:ctx _.scan set from storage doom.ui:mixer data[{uid:$(uid)}].content
function doom.ui:internal/mixer/count_higher with storage doom.ui:ctx _
data remove storage doom.ui:ctx _.scan
execute store result storage doom.ui:ctx _.ins int 1 run scoreboard players get #_ins dt.temp
# 已存在 → 重建（remove + 重新插入正确位置，修复 P-B）
execute if score #_f dt.temp matches 1.. run function doom.ui:internal/mixer/update_segment with storage doom.ui:ctx _

# 不存在 → 按位置插入
execute if score #_f dt.temp matches 0 run function doom.ui:internal/mixer/insert_segment with storage doom.ui:ctx _

