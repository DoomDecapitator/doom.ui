# doom.ui:internal/xpbar/tick -- main tick dispatch
execute store result storage doom.ui:ctx _.sid int 1 run scoreboard players get @s dt.sid_xp

scoreboard players operation #lvl dt.temp = @s dt.xp_time
scoreboard players add #lvl dt.temp 19
scoreboard players set #20 dt.temp 20
scoreboard players operation #lvl dt.temp /= #20 dt.temp
execute store result storage doom.ui:ctx _.lvl int 1 run scoreboard players get #lvl dt.temp

scoreboard players set #20 dt.temp 20
scoreboard players operation #tick dt.temp = @s dt.xp_time
scoreboard players operation #tick dt.temp %= #20 dt.temp

# Initialize #max_xp from current level
# ── 升级所需经验（MC 公式：L<=15 → 2L+7；16..30 → 5L-38；>=31 → 9L-158）──
# 2026-09-28 真机验收修（两处）：
#  ① 旧写法的三条分支**不是互斥的**：判据用的是被自己改过的 #max_xp。
#     等级 7 实测走成 7 → 14 → 21（落在 16..30）→ 105（落在 31..）→ 945-158 = **787**，
#     而正确值是 21。于是 #pts 被放大 37 倍，`experience add @s $(pts) points` 直接把等级顶上 23 ——
#     文档说的「等级倒计时」完全失效（实测 level 序列 23,22,21,… 而非 2,2,…,1,1）。
#  ② 基准等级取错：经验条百分比的分母必须是**显示等级** #lvl（tick_macro 里先
#     `experience set @s $(lvl) levels` 再 add points，分母就是 #lvl 的升级门槛）；
#     取玩家原始等级会让 pts 超过门槛，等级被顶上去（跳变）。
scoreboard players operation #lvl0 dt.temp = #lvl dt.temp
scoreboard players operation #max_xp dt.temp = #lvl0 dt.temp
execute if score #lvl0 dt.temp matches 0..15 run scoreboard players operation #max_xp dt.temp *= #2 dt.temp
execute if score #lvl0 dt.temp matches 0..15 run scoreboard players add #max_xp dt.temp 7
execute if score #lvl0 dt.temp matches 16..30 run scoreboard players operation #max_xp dt.temp *= #5 dt.temp
execute if score #lvl0 dt.temp matches 16..30 run scoreboard players remove #max_xp dt.temp 38
execute if score #lvl0 dt.temp matches 31.. run scoreboard players operation #max_xp dt.temp *= #9 dt.temp
execute if score #lvl0 dt.temp matches 31.. run scoreboard players remove #max_xp dt.temp 158

scoreboard players operation #pts dt.temp = #tick dt.temp
scoreboard players operation #pts dt.temp *= #max_xp dt.temp
scoreboard players set #20 dt.temp 20
scoreboard players operation #pts dt.temp /= #20 dt.temp
execute store result storage doom.ui:ctx _.pts int 1 run scoreboard players get #pts dt.temp

# 2026-09-28 新增：先处理「分数还在、会话没了」的孤儿（xpbar 运行中离线 / silent_clear_all 时不在线的玩家）
#   —— 否则经验永久停在被写坏的假显示值上（tick_macro 首行会 return 0）。
execute if data storage doom.ui:ctx _.sid run function doom.ui:internal/xpbar/orphan_guard with storage doom.ui:ctx _
execute if data storage doom.ui:ctx _.sid run function doom.ui:internal/xpbar/tick_macro with storage doom.ui:ctx _


