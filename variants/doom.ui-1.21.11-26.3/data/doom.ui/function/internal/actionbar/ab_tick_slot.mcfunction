# doom.ui:internal/actionbar/ab_tick_slot -- tick actionbar slot
scoreboard players set #time dt.temp 0
$scoreboard players set #time dt.temp $(time)
scoreboard players remove #time dt.temp 5
# Copy entire slot object, only modify time
data modify storage doom.ui:ctx _.temp set from storage doom.ui:ctx _.slot_processing
execute store result storage doom.ui:ctx _.temp.time int 1 run scoreboard players get #time dt.temp
$execute if score #time dt.temp matches 1.. run data modify storage doom.ui:ctx sessions.ab_$(uid) append from storage doom.ui:ctx _.temp
# ── fade 判真（2026-09-28 真机验收修）──────────────────────────────────────────
# `if data storage … _.temp.fade` 判的是**存在**：api 把 fade 默认成 true 后，
# 用户显式传 fade:false 时该字段存在且为 0b ⇒ 旧写的
#   `matches ..0 unless data …fade`（立即清除）永不执行，
#   `matches ..0 if data …fade`（走淡出）反而**总是**执行。
# 结果：fade:false 的 actionbar 到期后既不清除也不回调，一直挂在屏幕上。
# 按本包 README 的硬规则「判有效值必须转成 score 再 matches 1..」，这里先落成 #fade。
scoreboard players set #fade dt.temp 0
execute store result score #fade dt.temp run data get storage doom.ui:ctx _.temp.fade
# Expiry with fade: 把本实例的参数/回调存进 per-uid 路径，再交给 doom.schedule 排后续拍
# （原写法是原版 `schedule function … {uid:…,slot:…,step:5} 2t append`：1.21.6 的 /schedule
#  不接受宏参数，且 fade_chain 是宏函数 ⇒ `Expected float` / `Can't schedule a macro`；
#  宏函数的整批解析语义把这次失败放大成**整个 ab_tick_slot 被静默放弃** ——
#  实测后果：actionbar 会话永不推进（1 拍内条目消失、到期不消失、不淡出、on_fade 永不触发）。）
$execute if score #time dt.temp matches ..0 if score #fade dt.temp matches 1 run data remove storage doom.ui:ctx _.fade_next.$(uid)
$execute if score #time dt.temp matches ..0 if score #fade dt.temp matches 1 run data modify storage doom.ui:ctx _.fade_next.$(uid) set value {uid:$(uid),slot:"$(slot)",step:5}
$execute if score #time dt.temp matches ..0 if score #fade dt.temp matches 1 if data storage doom.ui:ctx _.temp.on_fade run data remove storage doom.ui:ctx _.fade_next.$(uid).on_fade
$execute if score #time dt.temp matches ..0 if score #fade dt.temp matches 1 if data storage doom.ui:ctx _.temp.on_fade run data modify storage doom.ui:ctx _.fade_next.$(uid).on_fade set from storage doom.ui:ctx _.temp.on_fade
$execute if score #time dt.temp matches ..0 if score #fade dt.temp matches 1 run function doom.ui:internal/actionbar/fade_schedule with storage doom.ui:ctx _.fade_next.$(uid)
# Expiry instant clear（fade=false / 未声明 fade）
$execute if score #time dt.temp matches ..0 if score #fade dt.temp matches 0 run data modify storage doom.ui:ctx _.id set value "dt.ab_$(slot)"
execute if score #time dt.temp matches ..0 if score #fade dt.temp matches 0 if data storage doom.ui:ctx _.temp.on_fade run function doom.ui:internal/exec_on_fade with storage doom.ui:ctx _.temp
execute if score #time dt.temp matches ..0 if score #fade dt.temp matches 0 run function doom.ui:internal/mixer/remove_segment with storage doom.ui:ctx _
