# doom.ui:api/silent_clear_all -- force clear all UI without callbacks
execute as @a run function doom.ui:internal/silent_clear_player
# Bossbar silent wipe
data modify storage doom.ui:ctx bossbars set value []
execute if data storage doom.ui:ctx active_bossbars[0] run function doom.ui:internal/bossbar/silent_wipe with storage doom.ui:ctx active_bossbars[0]
# Nuke all storage
data remove storage doom.ui:ctx sessions
data modify storage doom.ui:ctx sessions set value {}
data remove storage doom.ui:mixer data
data modify storage doom.ui:mixer data set value []
# [D17 fix] also drop the countdown-time lookup table (doom.ui:ctx cd_time.<slot>)
data remove storage doom.ui:ctx cd_time
data remove storage doom.ui:ctx active_bossbars
data modify storage doom.ui:ctx active_bossbars set value []
data remove storage doom.ui:ctx bossbars
data modify storage doom.ui:ctx bossbars set value []
data remove storage doom.ui:ctx bb_index
data modify storage doom.ui:ctx bb_index set value {}
data remove storage doom.ui:ctx _.text
data remove storage doom.ui:ctx _.tr
