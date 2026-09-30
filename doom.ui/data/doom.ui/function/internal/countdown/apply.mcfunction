# doom.ui:internal/countdown/apply -- apply settings to display
$data remove storage doom.ui:ctx sessions.cd_$(uid)[{slot:"$(slot)"}]
# 2026-09-28 新增（F-7）：**先**摘掉同槽旧条、再判 20 槽上限（否则覆盖已有槽会被误判为满）
#   满槽 ⇒ 丢弃本次请求（不建会话、不建 mixer 段）；旧版会留下永不到期的段。
function doom.ui:internal/countdown/slot_count with storage doom.ui:ctx _
execute if score #_slots dt.temp matches 20.. run return 0
$execute unless data storage doom.ui:ctx sessions.cd_$(uid) run data modify storage doom.ui:ctx sessions.cd_$(uid) set value []
$data modify storage doom.ui:ctx _.temp set value {uid:$(uid), slot:"$(slot)", time:$(time)}
$data modify storage doom.ui:ctx _.temp.id set value "dt.cd_$(slot)"
data modify storage doom.ui:ctx _.temp.priority set from storage doom.ui:ctx _.priority
data modify storage doom.ui:ctx _.temp.prefix set from storage doom.ui:ctx _.prefix
data modify storage doom.ui:ctx _.temp.on_fade set from storage doom.ui:ctx _.on_fade
data modify storage doom.ui:ctx _.temp.on_interrupt set from storage doom.ui:ctx _.on_interrupt
data modify storage doom.ui:ctx _.temp.on_interrupted_run set from storage doom.ui:ctx _.on_interrupted_run
$data modify storage doom.ui:ctx sessions.cd_$(uid) append from storage doom.ui:ctx _.temp
data modify storage doom.ui:ctx _.id set from storage doom.ui:ctx _.temp.id
# Build colored text: prefix color applies to time and s
# v4.22e（F-15）：API 契约里 prefix 是**列表**（prefix:[{text:"…",color:"…"}]）
#   旧写法 `set from _.prefix.color` 在列表上恒失败（静默）⇒ 秒数与 "s" 永远拿不到颜色、显示成默认白。
#   同时兼容"前缀给成单个复合"的老写法。
data remove storage doom.ui:ctx _.pcolor
execute if data storage doom.ui:ctx _.prefix[0].color run data modify storage doom.ui:ctx _.pcolor set from storage doom.ui:ctx _.prefix[0].color
execute if data storage doom.ui:ctx _.prefix.color run data modify storage doom.ui:ctx _.pcolor set from storage doom.ui:ctx _.prefix.color
data modify storage doom.ui:ctx _.seg set value {"text":"","extra":[]}
data modify storage doom.ui:ctx _.seg.color set from storage doom.ui:ctx _.pcolor
$data modify storage doom.ui:ctx _.seg.extra append value $(prefix)
data modify storage doom.ui:ctx _.seg.extra append value {text:": ",color:"white"}
data modify storage doom.ui:ctx _.seg_time set value {text:"","extra":[]}
execute if data storage doom.ui:ctx _.pcolor run data modify storage doom.ui:ctx _.seg_time.color set from storage doom.ui:ctx _.pcolor
$data modify storage doom.ui:ctx _.seg_time.extra append value {text:"$(time)"}
data modify storage doom.ui:ctx _.seg.extra append from storage doom.ui:ctx _.seg_time
data modify storage doom.ui:ctx _.seg_s set value {text:"s"}
execute if data storage doom.ui:ctx _.pcolor run data modify storage doom.ui:ctx _.seg_s.color set from storage doom.ui:ctx _.pcolor
data modify storage doom.ui:ctx _.seg.extra append from storage doom.ui:ctx _.seg_s
data remove storage doom.ui:ctx _.text
data modify storage doom.ui:ctx _.text set from storage doom.ui:ctx _.seg
data remove storage doom.ui:ctx _.seg
data remove storage doom.ui:ctx _.seg_time
data remove storage doom.ui:ctx _.seg_s
data remove storage doom.ui:ctx _.pcolor
function doom.ui:internal/mixer/set_segment with storage doom.ui:ctx _
function doom.ui:internal/mixer/process_single_macro with storage doom.ui:ctx _
$data modify storage doom.ui:mixer data[{uid:$(uid)}].content[{id:"dt.cd_$(slot)"}].type set value "cd"
