# doom.ui:internal/xpbar/silent_restore -- 静默还原经验（不发任何回调）
# 2026-09-28 真机验收新增：silent_clear_player 只 reset 了 dt.sid_xp / dt.xp_time，
# 既没走 xpbar/restore 也没还原经验 ⇒ 玩家等级/经验条永久停在 xpbar 期间写下的假值上
# （实测：真实 5 级，xpbar time=200 运行中被写到 9 级，silent_clear_all 之后仍是 9 级）。
# 宏参数来自 doom.ui:ctx _.xp_restore：lvl / pts
$experience set @s $(lvl) levels
experience set @s 0 points
$experience add @s $(pts) points
