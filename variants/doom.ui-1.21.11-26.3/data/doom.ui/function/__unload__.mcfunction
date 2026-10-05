function doom.ui:api/silent_clear_all

# doom.ui:__unload__ -- cleanup on datapack unload
scoreboard objectives remove dt.id
scoreboard objectives remove dt.uid
scoreboard objectives remove dt.leave
scoreboard objectives remove dt.deaths
scoreboard objectives remove dt.hp
scoreboard objectives remove dt.temp
scoreboard objectives remove dt.sid_al
scoreboard objectives remove dt.sid_fl
scoreboard objectives remove dt.sid_xp
scoreboard objectives remove dt.xp_lvl
scoreboard objectives remove dt.xp_pts
scoreboard objectives remove dt.xp_time
scoreboard objectives remove dt.xp_dead
scoreboard objectives remove dt.fl_r
scoreboard objectives remove dt.ab_remain
scoreboard objectives remove dt.interrupt

data remove storage doom.ui:ctx sessions
data remove storage doom.ui:ctx active_bossbars
data remove storage doom.ui:ctx bossbars
data remove storage doom.ui:ctx bb_index
data remove storage doom.ui:mixer data
data remove storage doom.ui:ctx _
data remove storage doom.ui:ctx _.tr

tellraw @a [{"text":"[DT] DBM 5.0 Unloaded.","color":"red"}]


