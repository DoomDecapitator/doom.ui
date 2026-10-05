# doom.ui:internal/leave_scan_next -- 递归弹出 _.ls[0]
execute if data storage doom.ui:ctx _.ls[0] run function doom.ui:internal/leave_scan_one with storage doom.ui:ctx _.ls[0]
data remove storage doom.ui:ctx _.ls[0]
execute if data storage doom.ui:ctx _.ls[0] run function doom.ui:internal/leave_scan_next
