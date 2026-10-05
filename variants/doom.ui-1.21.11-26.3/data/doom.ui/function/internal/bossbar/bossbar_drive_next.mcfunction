# doom.ui:internal/bossbar/bossbar_drive_next -- recursive processing of remaining bossbars
data remove storage doom.ui:ctx _.processing[0]
execute if data storage doom.ui:ctx _.processing[0] run execute store result storage doom.ui:ctx _.sid int 1 run data get storage doom.ui:ctx _.processing[0].sid
execute if data storage doom.ui:ctx _.processing[0] run function doom.ui:internal/bossbar/bossbar_tick_one with storage doom.ui:ctx _
execute if data storage doom.ui:ctx _.processing[0] run function doom.ui:internal/bossbar/bossbar_drive_next with storage doom.ui:ctx _
