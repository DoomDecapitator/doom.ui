# doom.ui:internal/alert/schedule_clear -- 排定 alert 的清除时刻
# 调用方式：function doom.ui:internal/alert/schedule_clear with storage doom.ui:ctx _
#   $(sid) / $(clear_time) 由 _ 快照提供（clear_time 已由 alert/apply 算好）
# 2026-09-28 真机验收修：到点应走 expire（自然到期，无条件 on_fade），
# 不能走 clear_macro（那是"被打断"的路径，要求 on_interrupt 才放行 on_fade）。
$function #doom.schedule:schedule {run: "function doom.ui:internal/alert/expire {sid: $(sid)}", time: $(clear_time), id: "dt.al_$(sid)", unit: "t"}
