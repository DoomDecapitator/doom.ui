# doom.ui:internal/actionbar/fade_schedule -- 把本实例排进下一拍（宏参数来自 _.fade_next.<uid>）
#
# 为什么单独一个文件：`#doom.schedule:schedule` 需要 run/time/unit/id 四个宏参数，
# 而调用点（ab_tick_slot / fade_chain）手里只有 per-uid 存储（_.fade_next.<uid>），
# 其中 step 是**递增后的当前值**（可能是 scoreboard 算出来的，宏行拿不到）。
# 单独一层就能把「快照」交给宏展开。
#
# 2026-09-28 真机验收新增（原实现用原版 /schedule，1.21.6 不支持带参调度宏函数）。
$function #doom.schedule:schedule {run: 'function doom.ui:internal/actionbar/fade_chain {uid:$(uid),slot:"$(slot)",step:$(step)}', time: 2, id: 'dt.abf_$(uid)_$(slot)', unit: "t"}
