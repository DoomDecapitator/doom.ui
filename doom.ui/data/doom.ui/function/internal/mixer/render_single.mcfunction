# doom.ui:internal/mixer/render_single -- render player's actionbar from per-uid title_root
# FIXED (P2): per-uid path _.tr.<uid> prevents multi-player cross-contamination
# 调用方式：function ... {uid: <uid>} 或 with storage doom.ui:ctx _（含 _.uid）
#
# FIXED (2026-09-11)：空渲染数组必须走 `title @s actionbar ""`。
#   build_title_arr 会把 _.tr.<uid> 初始化成 {text:"",extra:[]}；当该玩家没有任何段时
#   它就保持这个空形态。此时 `interpret:true` 解析**失败**，服务器打 WARN：
#     Failed to parse component: {extra:[],text:""}
#     java.lang.IllegalStateException: List must have contents
#   后果不只是噪音 —— "清空 actionbar"这个动作**实际没有生效**，
#   玩家会继续看到上一次的残留文本。实测每次 /reload 稳定出现 3 次。
$execute if data storage doom.ui:ctx _.tr.$(uid).extra[0] run title @s actionbar {"nbt":"_.tr.$(uid)","storage":"doom.ui:ctx","interpret":true}
$execute unless data storage doom.ui:ctx _.tr.$(uid).extra[0] run title @s actionbar ""
