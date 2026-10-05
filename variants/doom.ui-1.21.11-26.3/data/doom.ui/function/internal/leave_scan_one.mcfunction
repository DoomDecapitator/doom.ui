# doom.ui:internal/leave_scan_one -- 单个 uid 的离线回收
# 宏参数来自 doom.ui:ctx _.ls[0]：uid
$execute if entity @a[scores={dt.uid=$(uid)}] run return 0
$function doom.ui:internal/wipe_sessions {uid: $(uid)}
$function doom.ui:internal/clear_player_cd {uid: $(uid)}
$data remove storage doom.ui:mixer data[{uid:$(uid)}]
