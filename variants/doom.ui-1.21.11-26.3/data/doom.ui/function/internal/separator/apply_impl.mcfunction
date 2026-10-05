# doom.ui:internal/separator/apply_impl -- 写入分隔符
# 订正（2026-09-11）：下面第 4 行用的就是 filter 写法 data[{uid:$(uid)}]，**实测可用**
#   （探针 A2 目标端 filter、A5 单引号 filter + 字段读取，均通过）。
#   早期一度以为 filter 会静默失败并"绕开"过它，该结论已被证伪；代码保持原样，仅订正注释。
execute store result storage doom.ui:ctx _.uid int 1 run scoreboard players get @s dt.uid
data modify storage doom.ui:ctx _.tmp_uid set from storage doom.ui:ctx _.uid
# 2026-09-28 真机验收修：原来只有 `if data … data[{uid}]` 一个分支 —— 玩家还没有任何 mixer 条目时
# （= 还没用过 actionbar/countdown）调 api/separator 会**静默无效**，随后建段仍用默认 " | "。
# 现在缺条目就先补一条空条目（add_entry 的 $(uid) 来自 with storage 的 _，此处已就位）。
$execute unless data storage doom.ui:mixer data[{uid:$(uid)}] run function doom.ui:internal/mixer/add_entry with storage doom.ui:ctx _
$execute if data storage doom.ui:mixer data[{uid:$(uid)}] run data modify storage doom.ui:mixer data[{uid:$(uid)}].separator set from storage doom.ui:ctx _.separator
