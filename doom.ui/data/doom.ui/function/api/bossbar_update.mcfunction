# doom.ui:api/bossbar_update -- update bossbar max value dynamically (by bid)
# 约定（与 README 一致）：function doom.ui:api/bossbar_update {with:{bid:"default",new_time:200}}
#   旧版同时要 $(with) + $(bid) + $(new_time)，任何一种调用都缺参数。
data remove storage doom.ui:ctx _
$data modify storage doom.ui:ctx _ set value $(with)
execute unless data storage doom.ui:ctx _.bid run data modify storage doom.ui:ctx _.bid set value "default"
execute unless data storage doom.ui:ctx _.new_time run data modify storage doom.ui:ctx _.new_time set value 100
# 2026-09-28：`bossbar set <id> max <n>` 的参数是 IntegerArgumentType.integer(1)（BossBarCommands.java）
#   ⇒ new_time ≤ 0 是**解析期**错误，会让 update_impl 整批实例化失败、这次 update 静默无效。
#   这里先钳到 ≥1（与 api/bossbar 里 time ≤ 0 兜底 100 的取舍一致：兜底而非丢弃）。
execute store result score #_nt dt.temp run data get storage doom.ui:ctx _.new_time
execute if score #_nt dt.temp matches ..0 run scoreboard players set #_nt dt.temp 1
execute store result storage doom.ui:ctx _.new_time int 1 run scoreboard players get #_nt dt.temp
function doom.ui:internal/bossbar/update_dispatch with storage doom.ui:ctx _
data remove storage doom.ui:ctx _
