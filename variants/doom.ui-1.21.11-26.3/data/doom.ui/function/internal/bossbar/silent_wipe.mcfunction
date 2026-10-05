# doom.ui:internal/bossbar/silent_wipe -- silent wipe all bossbars without callbacks
$bossbar remove doom.ui:bb_$(sid)
data remove storage doom.ui:ctx active_bossbars[0]
execute if data storage doom.ui:ctx active_bossbars[0] run function doom.ui:internal/bossbar/silent_wipe with storage doom.ui:ctx active_bossbars[0]
