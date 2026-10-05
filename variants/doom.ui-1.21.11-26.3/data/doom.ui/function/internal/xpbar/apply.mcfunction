$data modify storage doom.ui:ctx sessions.xp_$(sid) set value {}
$data modify storage doom.ui:ctx sessions.xp_$(sid).on_fade set from storage doom.ui:ctx _.on_fade
$data modify storage doom.ui:ctx sessions.xp_$(sid).on_interrupt set from storage doom.ui:ctx _.on_interrupt
$data modify storage doom.ui:ctx sessions.xp_$(sid).on_interrupted_run set from storage doom.ui:ctx _.on_interrupted_run
$scoreboard players set @s dt.xp_time $(time)

