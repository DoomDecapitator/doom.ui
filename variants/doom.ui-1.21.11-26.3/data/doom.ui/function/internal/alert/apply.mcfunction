# doom.ui:internal/alert/apply -- apply settings to display
$data modify storage doom.ui:ctx sessions.al_$(sid) set value {}
$data modify storage doom.ui:ctx sessions.al_$(sid).on_fade set from storage doom.ui:ctx _.on_fade
$data modify storage doom.ui:ctx sessions.al_$(sid).on_interrupt set from storage doom.ui:ctx _.on_interrupt
$data modify storage doom.ui:ctx sessions.al_$(sid).on_interrupted_run set from storage doom.ui:ctx _.on_interrupted_run
execute unless data storage doom.ui:ctx _.priority run data modify storage doom.ui:ctx _.priority set value 30
$data modify storage doom.ui:ctx sessions.al_$(sid).priority set from storage doom.ui:ctx _.priority
$title @s times $(fade_in) $(time) $(fade_out)
$title @s subtitle $(subtitle)
$title @s title $(title)
# 清除时刻应为 title 的完整时长 fade_in + time + fade_out。
# 旧版只用 $(time)：fade_in 都还没走完就 reset/clear，整个淡出阶段被砍掉。
# 宏参数无法在行内由 scoreboard 计算 → 先算进 storage，再交给 schedule_clear（新调用能快照到）。
scoreboard players set #_al_t dt.temp 0
$scoreboard players set #_al_t dt.temp $(fade_in)
$scoreboard players add #_al_t dt.temp $(time)
$scoreboard players add #_al_t dt.temp $(fade_out)
execute store result storage doom.ui:ctx _.clear_time int 1 run scoreboard players get #_al_t dt.temp
function doom.ui:internal/alert/schedule_clear with storage doom.ui:ctx _


