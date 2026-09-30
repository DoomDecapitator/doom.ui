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

# ── 快路径（F-17）：段已存在且优先级没变 ⇒ 原位改文本 + 渲染后直接返回
#   （省掉 count_higher 的 20 次存储读与 remove/insert；countdown 每槽每秒都走这条）
execute if score #_f dt.temp matches 1.. if score #_f dt.temp = #_p dt.temp run function doom.ui:internal/mixer/update_text_in_place with storage doom.ui:ctx _
execute if score #_f dt.temp matches 1.. if score #_f dt.temp = #_p dt.temp run function doom.ui:internal/mixer/build_title_arr with storage doom.ui:ctx _
$execute if score #_f dt.temp matches 1.. if score #_f dt.temp = #_p dt.temp as @a[scores={dt.uid=$(uid)}] run function doom.ui:internal/mixer/render_single {uid: $(uid)}
execute if score #_f dt.temp matches 1.. if score #_f dt.temp = #_p dt.temp run return 0

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

function doom.ui:internal/mixer/build_title_arr with storage doom.ui:ctx _
$execute as @a[scores={dt.uid=$(uid)}] run function doom.ui:internal/mixer/render_single {uid: $(uid)}
