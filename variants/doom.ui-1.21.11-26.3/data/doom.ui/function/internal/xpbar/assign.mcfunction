# 2026-09-28 新增（F-12）：entry 只有 execute as $(targets)，掉落物/生物也会被分 uid 建会话
#   （实测 @e[type=item,limit=5] ⇒ 5 个掉落物各拿 uid 并写入 sessions/mixer）。这里按实体类型收口。
execute unless entity @s[type=minecraft:player] run return 0
# doom.ui:internal/xpbar/assign
# if data 对 0 也判真（sid 不存在时 store result 写的就是 0）→ 改 score 判定
execute store result score #_old dt.temp run scoreboard players get @s dt.sid_xp
execute if score #_old dt.temp matches 1.. run execute store result storage doom.ui:ctx _.sid int 1 run scoreboard players get #_old dt.temp
execute if score #_old dt.temp matches 1.. run function doom.ui:internal/xpbar/cleanup with storage doom.ui:ctx _
execute store result score @s dt.xp_lvl run experience query @s levels
execute store result score @s dt.xp_pts run experience query @s points
scoreboard players add #session dt.id 1
scoreboard players operation @s dt.sid_xp = #session dt.id
execute store result storage doom.ui:ctx _.sid int 1 run scoreboard players get @s dt.sid_xp
function doom.ui:internal/xpbar/apply with storage doom.ui:ctx _
