# doom.ui:internal/xpbar/orphan_guard -- 分数还在、会话没了的孤儿：静默还原经验并清分
#
# 2026-09-28 新增（源码依据 + 实测）：
#   · Player.displayClientMessage / ClientboundSetExperiencePacket 决定"显示值"只存在于客户端，
#     服务端真正的记录是 experienceLevel / experienceProgress / totalExperience（Player.java）；
#     xpbar 用 `experience set/add` 反复改写它，真实值靠 dt.xp_lvl / dt.xp_pts（assign 时抓取）保住。
#   · tick_macro 的首行是 `unless data sessions.xp_<sid> run return 0` ⇒ 一旦会话被清（玩家离线时
#     silent_clear_all、或 F-8 的回收），分数还在但会话没了，经验就永远停在被写坏的假显示值上。
#   这里在检测到"孤儿"时用 dt.xp_lvl / dt.xp_pts 静默还原（不发任何回调，与 silent 语义一致）。
# 宏参数来自 doom.ui:ctx _：sid
$execute if data storage doom.ui:ctx sessions.xp_$(sid) run return 0
execute if score @s dt.xp_time matches ..0 run return 0
execute store result storage doom.ui:ctx _.xp_restore.lvl int 1 run scoreboard players get @s dt.xp_lvl
execute store result storage doom.ui:ctx _.xp_restore.pts int 1 run scoreboard players get @s dt.xp_pts
function doom.ui:internal/xpbar/silent_restore with storage doom.ui:ctx _.xp_restore
data remove storage doom.ui:ctx _.xp_restore
scoreboard players reset @s dt.xp_time
scoreboard players reset @s dt.sid_xp
