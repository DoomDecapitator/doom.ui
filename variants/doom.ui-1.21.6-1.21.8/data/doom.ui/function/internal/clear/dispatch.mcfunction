# doom.ui:internal/clear/dispatch -- api/clear 的 type 分发
# 调用方式：function doom.ui:internal/clear/dispatch with storage doom.ui:ctx _
#   $(targets) 从 _.targets 取（宏快照在调用时捕获，故必须另起一层函数）
# type: 1=countdown 2=actionbar 3=player 4=bossbar
$execute if score #_clear_type dt.temp matches 1 as $(targets) run function doom.ui:internal/clear/clear_countdown
$execute if score #_clear_type dt.temp matches 2 if data storage doom.ui:ctx {_:{slot:"all"}} as $(targets) run function doom.ui:internal/clear/clear_actionbar
$execute if score #_clear_type dt.temp matches 2 unless data storage doom.ui:ctx {_:{slot:"all"}} as $(targets) run function doom.ui:internal/actionbar/ab_clear
$execute if score #_clear_type dt.temp matches 3 as $(targets) run function doom.ui:internal/clear_player
$execute if score #_clear_type dt.temp matches 3 as $(targets) run title @s actionbar ""
execute if score #_clear_type dt.temp matches 4 run function doom.ui:internal/bossbar/force_wipe
