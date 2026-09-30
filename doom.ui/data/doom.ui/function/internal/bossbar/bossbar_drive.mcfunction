# doom.ui:internal/bossbar/bossbar_drive -- process active bossbars recursively
data modify storage doom.ui:ctx _.processing set from storage doom.ui:ctx active_bossbars
data remove storage doom.ui:ctx active_bossbars
data modify storage doom.ui:ctx active_bossbars set value []
execute if data storage doom.ui:ctx _.processing[0] run execute store result storage doom.ui:ctx _.sid int 1 run data get storage doom.ui:ctx _.processing[0].sid
execute if data storage doom.ui:ctx _.processing[0] run function doom.ui:internal/bossbar/bossbar_tick_one with storage doom.ui:ctx _
execute if data storage doom.ui:ctx _.processing[0] run function doom.ui:internal/bossbar/bossbar_drive_next with storage doom.ui:ctx _
data remove storage doom.ui:ctx _.processing
