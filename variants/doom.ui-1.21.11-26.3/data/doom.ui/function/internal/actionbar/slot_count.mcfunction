# doom.ui:internal/actionbar/slot_count -- 统计本玩家 actionbar 会话槽数 → #_slots
# 2026-09-28 新增（F-7）：ab_tick_player 只回写 processing[0..9]（10 槽），第 11 槽会被静默丢弃，
# 但 apply 早已把 mixer 段建好 ⇒ 段永不到期、永久留在 actionbar 上（实测 11 段 vs 10 会话）。
# 满槽时直接在 apply 里 return 0（"超出丢弃"的语义落到"连段都不建"）。
# 宏参数来自 doom.ui:ctx _：uid
scoreboard players set #_slots dt.temp 0
$execute if data storage doom.ui:ctx sessions.ab_$(uid)[0] run scoreboard players add #_slots dt.temp 1
$execute if data storage doom.ui:ctx sessions.ab_$(uid)[1] run scoreboard players add #_slots dt.temp 1
$execute if data storage doom.ui:ctx sessions.ab_$(uid)[2] run scoreboard players add #_slots dt.temp 1
$execute if data storage doom.ui:ctx sessions.ab_$(uid)[3] run scoreboard players add #_slots dt.temp 1
$execute if data storage doom.ui:ctx sessions.ab_$(uid)[4] run scoreboard players add #_slots dt.temp 1
$execute if data storage doom.ui:ctx sessions.ab_$(uid)[5] run scoreboard players add #_slots dt.temp 1
$execute if data storage doom.ui:ctx sessions.ab_$(uid)[6] run scoreboard players add #_slots dt.temp 1
$execute if data storage doom.ui:ctx sessions.ab_$(uid)[7] run scoreboard players add #_slots dt.temp 1
$execute if data storage doom.ui:ctx sessions.ab_$(uid)[8] run scoreboard players add #_slots dt.temp 1
$execute if data storage doom.ui:ctx sessions.ab_$(uid)[9] run scoreboard players add #_slots dt.temp 1
