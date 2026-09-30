# 2026-09-28 新增（F-12）：entry 只有 execute as $(targets)，掉落物/生物也会被分 uid 建会话
#   （实测 @e[type=item,limit=5] ⇒ 5 个掉落物各拿 uid 并写入 sessions/mixer）。这里按实体类型收口。
execute unless entity @s[type=minecraft:player] run return 0
execute unless score @s dt.uid matches 1.. run function doom.ui:internal/mixer/add_player
execute store result storage doom.ui:ctx _.uid int 1 run scoreboard players get @s dt.uid
function doom.ui:internal/actionbar/cleanup with storage doom.ui:ctx _
function doom.ui:internal/actionbar/apply with storage doom.ui:ctx _

