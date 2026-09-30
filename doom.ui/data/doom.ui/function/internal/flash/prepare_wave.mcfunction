# doom.ui:internal/flash/prepare_wave -- prepare wave for display
$execute if data storage doom.ui:ctx sessions.fl_$(sid).flashes[$(wave)].title run data modify storage doom.ui:ctx _.has_title set value 1b
$execute if data storage doom.ui:ctx _.has_title run data modify storage doom.ui:ctx _.title set from storage doom.ui:ctx sessions.fl_$(sid).flashes[$(wave)].title
$execute unless data storage doom.ui:ctx _.has_title run data modify storage doom.ui:ctx _.title set from storage doom.ui:ctx sessions.fl_$(sid).title
$execute if data storage doom.ui:ctx sessions.fl_$(sid).flashes[$(wave)].subtitle run data modify storage doom.ui:ctx _.has_subtitle set value 1b
$execute if data storage doom.ui:ctx _.has_subtitle run data modify storage doom.ui:ctx _.subtitle set from storage doom.ui:ctx sessions.fl_$(sid).flashes[$(wave)].subtitle
$execute unless data storage doom.ui:ctx _.has_subtitle run data modify storage doom.ui:ctx _.subtitle set from storage doom.ui:ctx sessions.fl_$(sid).subtitle
# 先清空：避免上一波残留的 sound 被当成"本波有音效"
data remove storage doom.ui:ctx _.sound
$execute if data storage doom.ui:ctx sessions.fl_$(sid).flashes[$(wave)].sound run data modify storage doom.ui:ctx _.sound set from storage doom.ui:ctx sessions.fl_$(sid).flashes[$(wave)].sound
# 本波无 sound → 回退到会话级 sound。旧版这一行后面紧跟一句 data remove（同条件），把刚写的值删掉了。
$execute unless data storage doom.ui:ctx _.sound run execute if data storage doom.ui:ctx sessions.fl_$(sid).sound run data modify storage doom.ui:ctx _.sound set from storage doom.ui:ctx sessions.fl_$(sid).sound
data remove storage doom.ui:ctx _.has_title
data remove storage doom.ui:ctx _.has_subtitle
data remove storage doom.ui:ctx _.has_sound
function doom.ui:internal/flash/toggle_show with storage doom.ui:ctx _
data remove storage doom.ui:ctx _.sound_args
execute if data storage doom.ui:ctx _.sound run data modify storage doom.ui:ctx _.sound_args.sound set from storage doom.ui:ctx _.sound
execute if data storage doom.ui:ctx _.sound run function doom.ui:internal/flash/do_sound with storage doom.ui:ctx _.sound_args