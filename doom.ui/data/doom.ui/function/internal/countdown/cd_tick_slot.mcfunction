# doom.ui:internal/countdown/cd_tick_slot -- tick single countdown slot
scoreboard players set #time dt.temp 0
scoreboard players set #orig dt.temp 0
$scoreboard players set #time dt.temp $(time)
scoreboard players operation #orig dt.temp = #time dt.temp
scoreboard players remove #time dt.temp 1

# Active: original time >= 2
execute if score #orig dt.temp matches 2.. run data modify storage doom.ui:ctx _.temp set from storage doom.ui:ctx _.slot_processing
execute if score #orig dt.temp matches 2.. run execute store result storage doom.ui:ctx _.temp.time int 1 run scoreboard players get #time dt.temp
execute if score #orig dt.temp matches 2.. run data modify storage doom.ui:ctx _.id set from storage doom.ui:ctx _.temp.id
# seg_color 必须在被读之前写好：旧版第 14 行就读它、第 17 行才写 → 首帧无色，
# 且当 prefix 没有 color 时写入被跳过 → 保留**上一个槽**的颜色，导致槽间串色。
execute if score #orig dt.temp matches 2.. run data remove storage doom.ui:ctx _.seg_color
execute if score #orig dt.temp matches 2.. if data storage doom.ui:ctx _.temp.prefix[0].color run data modify storage doom.ui:ctx _.seg_color set from storage doom.ui:ctx _.temp.prefix[0].color
execute if score #orig dt.temp matches 2.. if data storage doom.ui:ctx _.temp.prefix.color run data modify storage doom.ui:ctx _.seg_color set from storage doom.ui:ctx _.temp.prefix.color
$execute if score #orig dt.temp matches 2.. run execute store result storage doom.ui:ctx cd_time.$(slot) int 1 run scoreboard players get #time dt.temp
execute if score #orig dt.temp matches 2.. run data modify storage doom.ui:ctx _.seg set value {text:"","extra":[]}
execute if score #orig dt.temp matches 2.. run data modify storage doom.ui:ctx _.seg.color set from storage doom.ui:ctx _.seg_color
execute if score #orig dt.temp matches 2.. run data modify storage doom.ui:ctx _.seg.extra append from storage doom.ui:ctx _.temp.prefix
execute if score #orig dt.temp matches 2.. run data modify storage doom.ui:ctx _.seg.extra append value {text:": ",color:"white"}
execute if score #orig dt.temp matches 2.. run data modify storage doom.ui:ctx _.seg_time set value {"text":"","extra":[]}
execute if score #orig dt.temp matches 2.. run data modify storage doom.ui:ctx _.seg_time.color set from storage doom.ui:ctx _.seg_color
$execute if score #orig dt.temp matches 2.. run data modify storage doom.ui:ctx _.seg_time.extra append value {"nbt":"cd_time.$(slot)","storage":"doom.ui:ctx"}
execute if score #orig dt.temp matches 2.. run data modify storage doom.ui:ctx _.seg.extra append from storage doom.ui:ctx _.seg_time
execute if score #orig dt.temp matches 2.. run data modify storage doom.ui:ctx _.seg_s set value {text:"s"}
execute if score #orig dt.temp matches 2.. run data modify storage doom.ui:ctx _.seg_s.color set from storage doom.ui:ctx _.seg_color
execute if score #orig dt.temp matches 2.. run data modify storage doom.ui:ctx _.seg.extra append from storage doom.ui:ctx _.seg_s
execute if score #orig dt.temp matches 2.. run data remove storage doom.ui:ctx _.text
execute if score #orig dt.temp matches 2.. run data modify storage doom.ui:ctx _.text set from storage doom.ui:ctx _.seg
execute if score #orig dt.temp matches 2.. run data modify storage doom.ui:ctx _.temp.text set from storage doom.ui:ctx _.text
# 旧版这里有一句 _.temp.id set from _.temp.id（自赋值空操作），已删
execute if score #orig dt.temp matches 2.. run data modify storage doom.ui:ctx _.priority set from storage doom.ui:ctx _.temp.priority
execute if score #orig dt.temp matches 2.. run function doom.ui:internal/mixer/set_segment_quiet with storage doom.ui:ctx _
$execute if score #orig dt.temp matches 2.. run data modify storage doom.ui:ctx sessions.cd_$(uid) append from storage doom.ui:ctx _.temp

# Expired: original time <= 1
# [D17 fix] drop the countdown time key when the slot expires (doom.ui:ctx cd_time.<slot>)
$execute if score #orig dt.temp matches ..1 run data remove storage doom.ui:ctx cd_time.$(slot)
execute if score #orig dt.temp matches ..1 run data modify storage doom.ui:ctx _.id set from storage doom.ui:ctx _.slot_processing.id
execute if score #orig dt.temp matches ..1 run function doom.ui:internal/mixer/remove_segment with storage doom.ui:ctx _
execute if score #orig dt.temp matches ..1 if data storage doom.ui:ctx _.slot_processing.on_fade run function doom.ui:internal/exec_on_fade with storage doom.ui:ctx _.slot_processing

data remove storage doom.ui:ctx _.temp
data remove storage doom.ui:ctx _.text
data remove storage doom.ui:ctx _.seg
data remove storage doom.ui:ctx _.seg_color
data remove storage doom.ui:ctx _.seg_time
data remove storage doom.ui:ctx _.seg_s
