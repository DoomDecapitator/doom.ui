# doom.ui:internal/mixer/update_text_in_place —— 段已存在且 priority 未变时，只改 .text（不动数组顺序）
#
# 为什么要这条快路径（2026-09-29 · F-17）：
#   countdown 的 tick 重建里，每个槽每秒调一次 set_segment；旧实现即使是"只改文本"也要走
#   count_higher（78 行、20 次 data get 存储读）+ remove_segment + insert_segment 全流程。
#   40 人 × 20 槽实测：只开 countdown ⇒ TPS 12.64；只开 actionbar ⇒ 19.57 —— 差的就是这条扫描。
#   语义上安全：priority 没变 ⇒ 段在数组里的位置本来就对；同优先级之间保持**先来后到**（FIFO），
#   与文件头写的"同 priority 新段插旧段之后（FIFO 稳定）"一致（旧实现在同优先级时会把它挪到组首，反而与注释矛盾）。
$execute if data storage doom.ui:ctx _.text run data modify storage doom.ui:mixer data[{uid:$(uid)}].content[{id:"$(id)"}].text set from storage doom.ui:ctx _.text
