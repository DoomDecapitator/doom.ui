# doom.ui:__debug__ -- debug information and state dump
tellraw @s {"text":"=== [DT] DBM 5.0 Memory Monitor ===","color":"gold","bold":true}
tellraw @s {"text":"1. Mixer Buffer:","color":"yellow"}
data get storage doom.ui:mixer data
tellraw @s {"text":"2. Active Sessions:","color":"yellow"}
data get storage doom.ui:ctx sessions
tellraw @s {"text":"3. Global Bossbars:","color":"yellow"}
data get storage doom.ui:ctx active_bossbars
data get storage doom.ui:ctx bossbars
tellraw @s {"text":"4. Your Local Scores:","color":"yellow"}
scoreboard players get @s dt.uid
scoreboard players get @s dt.sid_al
scoreboard players get @s dt.sid_fl
scoreboard players get @s dt.sid_xp
scoreboard players get @s dt.fl_r
scoreboard players get @s dt.ab_remain
scoreboard players get @s dt.xp_time
tellraw @s {"text":"5. Separator（随 mixer 条目，见上面 1）:","color":"yellow"}
tellraw @s {"text":"6. Bossbar bid → sid 映射:","color":"yellow"}
data get storage doom.ui:ctx bb_index
tellraw @s {"text":"7. Countdown 每槽剩余（_.cd_time）:","color":"yellow"}
data get storage doom.ui:ctx cd_time


