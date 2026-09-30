# doom.ui:internal/flash/apply -- apply settings to display
$data modify storage doom.ui:ctx sessions.fl_$(sid) set value {}
$data modify storage doom.ui:ctx sessions.fl_$(sid).on_fade set from storage doom.ui:ctx _.on_fade
$data modify storage doom.ui:ctx sessions.fl_$(sid).on_interrupt set from storage doom.ui:ctx _.on_interrupt
$data modify storage doom.ui:ctx sessions.fl_$(sid).on_interrupted_run set from storage doom.ui:ctx _.on_interrupted_run
$data modify storage doom.ui:ctx sessions.fl_$(sid).title set from storage doom.ui:ctx _.title
$data modify storage doom.ui:ctx sessions.fl_$(sid).subtitle set from storage doom.ui:ctx _.subtitle
$data modify storage doom.ui:ctx sessions.fl_$(sid).interval set value $(interval)
$data modify storage doom.ui:ctx sessions.fl_$(sid).count set value $(count)
$data modify storage doom.ui:ctx sessions.fl_$(sid).flashes set from storage doom.ui:ctx _.flashes
$data modify storage doom.ui:ctx sessions.fl_$(sid).sound set from storage doom.ui:ctx _.sound
execute unless data storage doom.ui:ctx _.priority run data modify storage doom.ui:ctx _.priority set value 40
$data modify storage doom.ui:ctx sessions.fl_$(sid).priority set from storage doom.ui:ctx _.priority
$scoreboard players set @s dt.fl_r $(count)
scoreboard players set #2 dt.temp 2
scoreboard players operation @s dt.fl_r *= #2 dt.temp
title @s times 0 200 0
$title @s title $(title)
$title @s subtitle $(subtitle)
$function doom.ui:internal/flash/toggle_macro {sid: $(sid), interval: $(interval)}


