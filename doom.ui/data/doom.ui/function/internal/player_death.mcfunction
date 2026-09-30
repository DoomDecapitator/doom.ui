# doom.ui:internal/player_death -- restore xpbar on death
# if data 对 0 也判真 → 改 score 判定（sid_xp 不存在时不该走 restore）
execute store result score #_old dt.temp run scoreboard players get @s dt.sid_xp
execute if score #_old dt.temp matches 1.. run scoreboard players reset @s dt.xp_time
execute if score #_old dt.temp matches 1.. run function doom.ui:internal/xpbar/restore with storage doom.ui:ctx _
scoreboard players reset @s dt.deaths
