# doom.ui:internal/bossbar/bossbar_tick_one -- tick single bossbar entry
$execute store result score #_show dt.temp run data get storage doom.ui:ctx sessions.bb_$(sid).show_sec
$execute store result score #val dt.temp run bossbar get doom.ui:bb_$(sid) value
scoreboard players remove #val dt.temp 1
$execute store result bossbar doom.ui:bb_$(sid) value run scoreboard players get #val dt.temp
execute if score #_show dt.temp matches 1 run scoreboard players operation #sec dt.temp = #val dt.temp
execute if score #_show dt.temp matches 1 run scoreboard players add #sec dt.temp 19
execute if score #_show dt.temp matches 1 run scoreboard players set #20 dt.temp 20
execute if score #_show dt.temp matches 1 run scoreboard players operation #sec dt.temp /= #20 dt.temp
$data modify storage doom.ui:ctx _.temp.name set from storage doom.ui:ctx sessions.bb_$(sid).name
$data modify storage doom.ui:ctx _.temp.sep set from storage doom.ui:ctx sessions.bb_$(sid).sep
$execute if score #_show dt.temp matches 1 run bossbar set doom.ui:bb_$(sid) name [{"nbt":"_.temp.name","storage":"doom.ui:ctx","interpret":true},{"nbt":"_.temp.sep","storage":"doom.ui:ctx","interpret":true},{"score":{"name":"#sec","objective":"dt.temp"}}]
$execute if score #val dt.temp matches 1.. run data modify storage doom.ui:ctx active_bossbars append value {sid: $(sid)}
execute if score #val dt.temp matches ..0 run data remove storage doom.ui:ctx _.temp.on_fade
$execute if score #val dt.temp matches ..0 run data modify storage doom.ui:ctx _.temp.on_fade set from storage doom.ui:ctx sessions.bb_$(sid).on_fade
execute if score #val dt.temp matches ..0 if data storage doom.ui:ctx _.temp.on_fade run function doom.ui:internal/exec_on_fade with storage doom.ui:ctx _.temp
$execute if score #val dt.temp matches ..0 run bossbar remove doom.ui:bb_$(sid)
# 2026-09-28 真机验收修：bid 必须在删 sessions **之前**读（原顺序永远读到空串 ⇒ bb_index 残留幽灵条目；
#   随后按旧 bid 调 bossbar_update 会在死 sid 上重建会话 —— 与 force_wipe_macro 同一类 bug）。
execute if score #val dt.temp matches ..0 run data modify storage doom.ui:ctx _.bb_expire set value {bid:""}
$execute if score #val dt.temp matches ..0 run data modify storage doom.ui:ctx _.bb_expire.bid set from storage doom.ui:ctx sessions.bb_$(sid).bid
$execute if score #val dt.temp matches ..0 run data remove storage doom.ui:ctx sessions.bb_$(sid)
$execute if score #val dt.temp matches ..0 run data remove storage doom.ui:ctx active_bossbars[{sid:$(sid)}]
$execute if score #val dt.temp matches ..0 run data remove storage doom.ui:ctx bossbars[{sid:$(sid)}]
execute if score #val dt.temp matches ..0 run function doom.ui:internal/bossbar/drop_bid with storage doom.ui:ctx _.bb_expire
