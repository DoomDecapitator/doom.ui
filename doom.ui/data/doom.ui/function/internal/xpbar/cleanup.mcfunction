# doom.ui:internal/xpbar/cleanup -- cleanup xpbar session
$data remove storage doom.ui:ctx sessions.xp_$(sid)
scoreboard players reset @s dt.sid_xp
