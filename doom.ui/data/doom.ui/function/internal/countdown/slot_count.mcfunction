# doom.ui:internal/countdown/slot_count -- 统计本玩家 countdown 会话槽数 → #_slots
# 2026-09-28 新增（F-7）：cd_tick_player 只回写 processing[0..19]（20 槽），第 21 槽被丢弃但段会残留。
# 宏参数来自 doom.ui:ctx _：uid
scoreboard players set #_slots dt.temp 0
$execute if data storage doom.ui:ctx sessions.cd_$(uid)[0] run scoreboard players add #_slots dt.temp 1
$execute if data storage doom.ui:ctx sessions.cd_$(uid)[1] run scoreboard players add #_slots dt.temp 1
$execute if data storage doom.ui:ctx sessions.cd_$(uid)[2] run scoreboard players add #_slots dt.temp 1
$execute if data storage doom.ui:ctx sessions.cd_$(uid)[3] run scoreboard players add #_slots dt.temp 1
$execute if data storage doom.ui:ctx sessions.cd_$(uid)[4] run scoreboard players add #_slots dt.temp 1
$execute if data storage doom.ui:ctx sessions.cd_$(uid)[5] run scoreboard players add #_slots dt.temp 1
$execute if data storage doom.ui:ctx sessions.cd_$(uid)[6] run scoreboard players add #_slots dt.temp 1
$execute if data storage doom.ui:ctx sessions.cd_$(uid)[7] run scoreboard players add #_slots dt.temp 1
$execute if data storage doom.ui:ctx sessions.cd_$(uid)[8] run scoreboard players add #_slots dt.temp 1
$execute if data storage doom.ui:ctx sessions.cd_$(uid)[9] run scoreboard players add #_slots dt.temp 1
$execute if data storage doom.ui:ctx sessions.cd_$(uid)[10] run scoreboard players add #_slots dt.temp 1
$execute if data storage doom.ui:ctx sessions.cd_$(uid)[11] run scoreboard players add #_slots dt.temp 1
$execute if data storage doom.ui:ctx sessions.cd_$(uid)[12] run scoreboard players add #_slots dt.temp 1
$execute if data storage doom.ui:ctx sessions.cd_$(uid)[13] run scoreboard players add #_slots dt.temp 1
$execute if data storage doom.ui:ctx sessions.cd_$(uid)[14] run scoreboard players add #_slots dt.temp 1
$execute if data storage doom.ui:ctx sessions.cd_$(uid)[15] run scoreboard players add #_slots dt.temp 1
$execute if data storage doom.ui:ctx sessions.cd_$(uid)[16] run scoreboard players add #_slots dt.temp 1
$execute if data storage doom.ui:ctx sessions.cd_$(uid)[17] run scoreboard players add #_slots dt.temp 1
$execute if data storage doom.ui:ctx sessions.cd_$(uid)[18] run scoreboard players add #_slots dt.temp 1
$execute if data storage doom.ui:ctx sessions.cd_$(uid)[19] run scoreboard players add #_slots dt.temp 1
