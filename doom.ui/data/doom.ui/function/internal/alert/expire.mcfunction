# doom.ui:internal/alert/expire -- alert 自然到期（不是被打断）
# 2026-09-28 真机验收新增：原来 schedule_clear 到点调的是 clear_macro，而 clear_macro 里
# on_fade 的门控是「unless on_interrupted_run if on_interrupt if on_fade」——
# 也就是**必须同时给 on_interrupt** 才跑。实测：只给 on_fade 的 alert 到期后清屏了、
# on_fade 却一次都不触发（doom.schedule 队列里任务确实执行了）。而兄弟路径
# （countdown 到期 / actionbar 到期 / bossbar 到期 / flash 自然结束）都是无条件跑 on_fade。
# 自然到期 = 不是被打断 ⇒ 这里无条件执行 on_fade，再走公共清理。
$execute unless data storage doom.ui:ctx sessions.al_$(sid) run return 0
data remove storage doom.ui:ctx _.temp.on_fade
$data modify storage doom.ui:ctx _.temp.on_fade set from storage doom.ui:ctx sessions.al_$(sid).on_fade
execute if data storage doom.ui:ctx _.temp.on_fade run function doom.ui:internal/exec_on_fade with storage doom.ui:ctx _.temp
$function doom.ui:internal/alert/cleanup {sid: $(sid)}
