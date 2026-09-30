# doom.ui:internal/mixer/build_title_arr -- build title root from mixer data (20 slots)
# FIXED (M2/M4): 每段 append 整个 text compound (不再 text[0..3] 索引)
# FIXED (H5): 分隔符错位 —— 旧版对每个 i>=1 先 append content[i].text 再 append separator，
#   得到 [t0, t1, sep, t2, sep, ...]：头两段粘连、末尾永远多一个分隔符。
#   现改为「先 sep 再 text」，得到正确的 [t0, sep, t1, sep, t2, ...]。
$data remove storage doom.ui:ctx _.tr.$(uid)
$data modify storage doom.ui:ctx _.tr.$(uid) set value {text:"",extra:[]}

# 第 0 段：无前置分隔符
$execute if data storage doom.ui:mixer data[{uid:$(uid)}].content[0].text run data modify storage doom.ui:ctx _.tr.$(uid).extra append from storage doom.ui:mixer data[{uid:$(uid)}].content[0].text

# 第 1 段：分隔符在前
$execute if data storage doom.ui:mixer data[{uid:$(uid)}].content[1].text if data storage doom.ui:ctx _.tr.$(uid).extra[0] run data modify storage doom.ui:ctx _.sep_data set from storage doom.ui:mixer data[{uid:$(uid)}].separator
$execute if data storage doom.ui:mixer data[{uid:$(uid)}].content[1].text if data storage doom.ui:ctx _.tr.$(uid).extra[0] run data modify storage doom.ui:ctx _.tr.$(uid).extra append from storage doom.ui:ctx _.sep_data
$execute if data storage doom.ui:mixer data[{uid:$(uid)}].content[1].text if data storage doom.ui:ctx _.tr.$(uid).extra[0] run data remove storage doom.ui:ctx _.sep_data
$execute if data storage doom.ui:mixer data[{uid:$(uid)}].content[1].text run data modify storage doom.ui:ctx _.tr.$(uid).extra append from storage doom.ui:mixer data[{uid:$(uid)}].content[1].text
# 第 2 段：分隔符在前
$execute if data storage doom.ui:mixer data[{uid:$(uid)}].content[2].text if data storage doom.ui:ctx _.tr.$(uid).extra[0] run data modify storage doom.ui:ctx _.sep_data set from storage doom.ui:mixer data[{uid:$(uid)}].separator
$execute if data storage doom.ui:mixer data[{uid:$(uid)}].content[2].text if data storage doom.ui:ctx _.tr.$(uid).extra[0] run data modify storage doom.ui:ctx _.tr.$(uid).extra append from storage doom.ui:ctx _.sep_data
$execute if data storage doom.ui:mixer data[{uid:$(uid)}].content[2].text if data storage doom.ui:ctx _.tr.$(uid).extra[0] run data remove storage doom.ui:ctx _.sep_data
$execute if data storage doom.ui:mixer data[{uid:$(uid)}].content[2].text run data modify storage doom.ui:ctx _.tr.$(uid).extra append from storage doom.ui:mixer data[{uid:$(uid)}].content[2].text
# 第 3 段：分隔符在前
$execute if data storage doom.ui:mixer data[{uid:$(uid)}].content[3].text if data storage doom.ui:ctx _.tr.$(uid).extra[0] run data modify storage doom.ui:ctx _.sep_data set from storage doom.ui:mixer data[{uid:$(uid)}].separator
$execute if data storage doom.ui:mixer data[{uid:$(uid)}].content[3].text if data storage doom.ui:ctx _.tr.$(uid).extra[0] run data modify storage doom.ui:ctx _.tr.$(uid).extra append from storage doom.ui:ctx _.sep_data
$execute if data storage doom.ui:mixer data[{uid:$(uid)}].content[3].text if data storage doom.ui:ctx _.tr.$(uid).extra[0] run data remove storage doom.ui:ctx _.sep_data
$execute if data storage doom.ui:mixer data[{uid:$(uid)}].content[3].text run data modify storage doom.ui:ctx _.tr.$(uid).extra append from storage doom.ui:mixer data[{uid:$(uid)}].content[3].text
# 第 4 段：分隔符在前
$execute if data storage doom.ui:mixer data[{uid:$(uid)}].content[4].text if data storage doom.ui:ctx _.tr.$(uid).extra[0] run data modify storage doom.ui:ctx _.sep_data set from storage doom.ui:mixer data[{uid:$(uid)}].separator
$execute if data storage doom.ui:mixer data[{uid:$(uid)}].content[4].text if data storage doom.ui:ctx _.tr.$(uid).extra[0] run data modify storage doom.ui:ctx _.tr.$(uid).extra append from storage doom.ui:ctx _.sep_data
$execute if data storage doom.ui:mixer data[{uid:$(uid)}].content[4].text if data storage doom.ui:ctx _.tr.$(uid).extra[0] run data remove storage doom.ui:ctx _.sep_data
$execute if data storage doom.ui:mixer data[{uid:$(uid)}].content[4].text run data modify storage doom.ui:ctx _.tr.$(uid).extra append from storage doom.ui:mixer data[{uid:$(uid)}].content[4].text
# 第 5 段：分隔符在前
$execute if data storage doom.ui:mixer data[{uid:$(uid)}].content[5].text if data storage doom.ui:ctx _.tr.$(uid).extra[0] run data modify storage doom.ui:ctx _.sep_data set from storage doom.ui:mixer data[{uid:$(uid)}].separator
$execute if data storage doom.ui:mixer data[{uid:$(uid)}].content[5].text if data storage doom.ui:ctx _.tr.$(uid).extra[0] run data modify storage doom.ui:ctx _.tr.$(uid).extra append from storage doom.ui:ctx _.sep_data
$execute if data storage doom.ui:mixer data[{uid:$(uid)}].content[5].text if data storage doom.ui:ctx _.tr.$(uid).extra[0] run data remove storage doom.ui:ctx _.sep_data
$execute if data storage doom.ui:mixer data[{uid:$(uid)}].content[5].text run data modify storage doom.ui:ctx _.tr.$(uid).extra append from storage doom.ui:mixer data[{uid:$(uid)}].content[5].text
# 第 6 段：分隔符在前
$execute if data storage doom.ui:mixer data[{uid:$(uid)}].content[6].text if data storage doom.ui:ctx _.tr.$(uid).extra[0] run data modify storage doom.ui:ctx _.sep_data set from storage doom.ui:mixer data[{uid:$(uid)}].separator
$execute if data storage doom.ui:mixer data[{uid:$(uid)}].content[6].text if data storage doom.ui:ctx _.tr.$(uid).extra[0] run data modify storage doom.ui:ctx _.tr.$(uid).extra append from storage doom.ui:ctx _.sep_data
$execute if data storage doom.ui:mixer data[{uid:$(uid)}].content[6].text if data storage doom.ui:ctx _.tr.$(uid).extra[0] run data remove storage doom.ui:ctx _.sep_data
$execute if data storage doom.ui:mixer data[{uid:$(uid)}].content[6].text run data modify storage doom.ui:ctx _.tr.$(uid).extra append from storage doom.ui:mixer data[{uid:$(uid)}].content[6].text
# 第 7 段：分隔符在前
$execute if data storage doom.ui:mixer data[{uid:$(uid)}].content[7].text if data storage doom.ui:ctx _.tr.$(uid).extra[0] run data modify storage doom.ui:ctx _.sep_data set from storage doom.ui:mixer data[{uid:$(uid)}].separator
$execute if data storage doom.ui:mixer data[{uid:$(uid)}].content[7].text if data storage doom.ui:ctx _.tr.$(uid).extra[0] run data modify storage doom.ui:ctx _.tr.$(uid).extra append from storage doom.ui:ctx _.sep_data
$execute if data storage doom.ui:mixer data[{uid:$(uid)}].content[7].text if data storage doom.ui:ctx _.tr.$(uid).extra[0] run data remove storage doom.ui:ctx _.sep_data
$execute if data storage doom.ui:mixer data[{uid:$(uid)}].content[7].text run data modify storage doom.ui:ctx _.tr.$(uid).extra append from storage doom.ui:mixer data[{uid:$(uid)}].content[7].text
# 第 8 段：分隔符在前
$execute if data storage doom.ui:mixer data[{uid:$(uid)}].content[8].text if data storage doom.ui:ctx _.tr.$(uid).extra[0] run data modify storage doom.ui:ctx _.sep_data set from storage doom.ui:mixer data[{uid:$(uid)}].separator
$execute if data storage doom.ui:mixer data[{uid:$(uid)}].content[8].text if data storage doom.ui:ctx _.tr.$(uid).extra[0] run data modify storage doom.ui:ctx _.tr.$(uid).extra append from storage doom.ui:ctx _.sep_data
$execute if data storage doom.ui:mixer data[{uid:$(uid)}].content[8].text if data storage doom.ui:ctx _.tr.$(uid).extra[0] run data remove storage doom.ui:ctx _.sep_data
$execute if data storage doom.ui:mixer data[{uid:$(uid)}].content[8].text run data modify storage doom.ui:ctx _.tr.$(uid).extra append from storage doom.ui:mixer data[{uid:$(uid)}].content[8].text
# 第 9 段：分隔符在前
$execute if data storage doom.ui:mixer data[{uid:$(uid)}].content[9].text if data storage doom.ui:ctx _.tr.$(uid).extra[0] run data modify storage doom.ui:ctx _.sep_data set from storage doom.ui:mixer data[{uid:$(uid)}].separator
$execute if data storage doom.ui:mixer data[{uid:$(uid)}].content[9].text if data storage doom.ui:ctx _.tr.$(uid).extra[0] run data modify storage doom.ui:ctx _.tr.$(uid).extra append from storage doom.ui:ctx _.sep_data
$execute if data storage doom.ui:mixer data[{uid:$(uid)}].content[9].text if data storage doom.ui:ctx _.tr.$(uid).extra[0] run data remove storage doom.ui:ctx _.sep_data
$execute if data storage doom.ui:mixer data[{uid:$(uid)}].content[9].text run data modify storage doom.ui:ctx _.tr.$(uid).extra append from storage doom.ui:mixer data[{uid:$(uid)}].content[9].text
# 第 10 段：分隔符在前
$execute if data storage doom.ui:mixer data[{uid:$(uid)}].content[10].text if data storage doom.ui:ctx _.tr.$(uid).extra[0] run data modify storage doom.ui:ctx _.sep_data set from storage doom.ui:mixer data[{uid:$(uid)}].separator
$execute if data storage doom.ui:mixer data[{uid:$(uid)}].content[10].text if data storage doom.ui:ctx _.tr.$(uid).extra[0] run data modify storage doom.ui:ctx _.tr.$(uid).extra append from storage doom.ui:ctx _.sep_data
$execute if data storage doom.ui:mixer data[{uid:$(uid)}].content[10].text if data storage doom.ui:ctx _.tr.$(uid).extra[0] run data remove storage doom.ui:ctx _.sep_data
$execute if data storage doom.ui:mixer data[{uid:$(uid)}].content[10].text run data modify storage doom.ui:ctx _.tr.$(uid).extra append from storage doom.ui:mixer data[{uid:$(uid)}].content[10].text
# 第 11 段：分隔符在前
$execute if data storage doom.ui:mixer data[{uid:$(uid)}].content[11].text if data storage doom.ui:ctx _.tr.$(uid).extra[0] run data modify storage doom.ui:ctx _.sep_data set from storage doom.ui:mixer data[{uid:$(uid)}].separator
$execute if data storage doom.ui:mixer data[{uid:$(uid)}].content[11].text if data storage doom.ui:ctx _.tr.$(uid).extra[0] run data modify storage doom.ui:ctx _.tr.$(uid).extra append from storage doom.ui:ctx _.sep_data
$execute if data storage doom.ui:mixer data[{uid:$(uid)}].content[11].text if data storage doom.ui:ctx _.tr.$(uid).extra[0] run data remove storage doom.ui:ctx _.sep_data
$execute if data storage doom.ui:mixer data[{uid:$(uid)}].content[11].text run data modify storage doom.ui:ctx _.tr.$(uid).extra append from storage doom.ui:mixer data[{uid:$(uid)}].content[11].text
# 第 12 段：分隔符在前
$execute if data storage doom.ui:mixer data[{uid:$(uid)}].content[12].text if data storage doom.ui:ctx _.tr.$(uid).extra[0] run data modify storage doom.ui:ctx _.sep_data set from storage doom.ui:mixer data[{uid:$(uid)}].separator
$execute if data storage doom.ui:mixer data[{uid:$(uid)}].content[12].text if data storage doom.ui:ctx _.tr.$(uid).extra[0] run data modify storage doom.ui:ctx _.tr.$(uid).extra append from storage doom.ui:ctx _.sep_data
$execute if data storage doom.ui:mixer data[{uid:$(uid)}].content[12].text if data storage doom.ui:ctx _.tr.$(uid).extra[0] run data remove storage doom.ui:ctx _.sep_data
$execute if data storage doom.ui:mixer data[{uid:$(uid)}].content[12].text run data modify storage doom.ui:ctx _.tr.$(uid).extra append from storage doom.ui:mixer data[{uid:$(uid)}].content[12].text
# 第 13 段：分隔符在前
$execute if data storage doom.ui:mixer data[{uid:$(uid)}].content[13].text if data storage doom.ui:ctx _.tr.$(uid).extra[0] run data modify storage doom.ui:ctx _.sep_data set from storage doom.ui:mixer data[{uid:$(uid)}].separator
$execute if data storage doom.ui:mixer data[{uid:$(uid)}].content[13].text if data storage doom.ui:ctx _.tr.$(uid).extra[0] run data modify storage doom.ui:ctx _.tr.$(uid).extra append from storage doom.ui:ctx _.sep_data
$execute if data storage doom.ui:mixer data[{uid:$(uid)}].content[13].text if data storage doom.ui:ctx _.tr.$(uid).extra[0] run data remove storage doom.ui:ctx _.sep_data
$execute if data storage doom.ui:mixer data[{uid:$(uid)}].content[13].text run data modify storage doom.ui:ctx _.tr.$(uid).extra append from storage doom.ui:mixer data[{uid:$(uid)}].content[13].text
# 第 14 段：分隔符在前
$execute if data storage doom.ui:mixer data[{uid:$(uid)}].content[14].text if data storage doom.ui:ctx _.tr.$(uid).extra[0] run data modify storage doom.ui:ctx _.sep_data set from storage doom.ui:mixer data[{uid:$(uid)}].separator
$execute if data storage doom.ui:mixer data[{uid:$(uid)}].content[14].text if data storage doom.ui:ctx _.tr.$(uid).extra[0] run data modify storage doom.ui:ctx _.tr.$(uid).extra append from storage doom.ui:ctx _.sep_data
$execute if data storage doom.ui:mixer data[{uid:$(uid)}].content[14].text if data storage doom.ui:ctx _.tr.$(uid).extra[0] run data remove storage doom.ui:ctx _.sep_data
$execute if data storage doom.ui:mixer data[{uid:$(uid)}].content[14].text run data modify storage doom.ui:ctx _.tr.$(uid).extra append from storage doom.ui:mixer data[{uid:$(uid)}].content[14].text
# 第 15 段：分隔符在前
$execute if data storage doom.ui:mixer data[{uid:$(uid)}].content[15].text if data storage doom.ui:ctx _.tr.$(uid).extra[0] run data modify storage doom.ui:ctx _.sep_data set from storage doom.ui:mixer data[{uid:$(uid)}].separator
$execute if data storage doom.ui:mixer data[{uid:$(uid)}].content[15].text if data storage doom.ui:ctx _.tr.$(uid).extra[0] run data modify storage doom.ui:ctx _.tr.$(uid).extra append from storage doom.ui:ctx _.sep_data
$execute if data storage doom.ui:mixer data[{uid:$(uid)}].content[15].text if data storage doom.ui:ctx _.tr.$(uid).extra[0] run data remove storage doom.ui:ctx _.sep_data
$execute if data storage doom.ui:mixer data[{uid:$(uid)}].content[15].text run data modify storage doom.ui:ctx _.tr.$(uid).extra append from storage doom.ui:mixer data[{uid:$(uid)}].content[15].text
# 第 16 段：分隔符在前
$execute if data storage doom.ui:mixer data[{uid:$(uid)}].content[16].text if data storage doom.ui:ctx _.tr.$(uid).extra[0] run data modify storage doom.ui:ctx _.sep_data set from storage doom.ui:mixer data[{uid:$(uid)}].separator
$execute if data storage doom.ui:mixer data[{uid:$(uid)}].content[16].text if data storage doom.ui:ctx _.tr.$(uid).extra[0] run data modify storage doom.ui:ctx _.tr.$(uid).extra append from storage doom.ui:ctx _.sep_data
$execute if data storage doom.ui:mixer data[{uid:$(uid)}].content[16].text if data storage doom.ui:ctx _.tr.$(uid).extra[0] run data remove storage doom.ui:ctx _.sep_data
$execute if data storage doom.ui:mixer data[{uid:$(uid)}].content[16].text run data modify storage doom.ui:ctx _.tr.$(uid).extra append from storage doom.ui:mixer data[{uid:$(uid)}].content[16].text
# 第 17 段：分隔符在前
$execute if data storage doom.ui:mixer data[{uid:$(uid)}].content[17].text if data storage doom.ui:ctx _.tr.$(uid).extra[0] run data modify storage doom.ui:ctx _.sep_data set from storage doom.ui:mixer data[{uid:$(uid)}].separator
$execute if data storage doom.ui:mixer data[{uid:$(uid)}].content[17].text if data storage doom.ui:ctx _.tr.$(uid).extra[0] run data modify storage doom.ui:ctx _.tr.$(uid).extra append from storage doom.ui:ctx _.sep_data
$execute if data storage doom.ui:mixer data[{uid:$(uid)}].content[17].text if data storage doom.ui:ctx _.tr.$(uid).extra[0] run data remove storage doom.ui:ctx _.sep_data
$execute if data storage doom.ui:mixer data[{uid:$(uid)}].content[17].text run data modify storage doom.ui:ctx _.tr.$(uid).extra append from storage doom.ui:mixer data[{uid:$(uid)}].content[17].text
# 第 18 段：分隔符在前
$execute if data storage doom.ui:mixer data[{uid:$(uid)}].content[18].text if data storage doom.ui:ctx _.tr.$(uid).extra[0] run data modify storage doom.ui:ctx _.sep_data set from storage doom.ui:mixer data[{uid:$(uid)}].separator
$execute if data storage doom.ui:mixer data[{uid:$(uid)}].content[18].text if data storage doom.ui:ctx _.tr.$(uid).extra[0] run data modify storage doom.ui:ctx _.tr.$(uid).extra append from storage doom.ui:ctx _.sep_data
$execute if data storage doom.ui:mixer data[{uid:$(uid)}].content[18].text if data storage doom.ui:ctx _.tr.$(uid).extra[0] run data remove storage doom.ui:ctx _.sep_data
$execute if data storage doom.ui:mixer data[{uid:$(uid)}].content[18].text run data modify storage doom.ui:ctx _.tr.$(uid).extra append from storage doom.ui:mixer data[{uid:$(uid)}].content[18].text
# 第 19 段：分隔符在前
$execute if data storage doom.ui:mixer data[{uid:$(uid)}].content[19].text if data storage doom.ui:ctx _.tr.$(uid).extra[0] run data modify storage doom.ui:ctx _.sep_data set from storage doom.ui:mixer data[{uid:$(uid)}].separator
$execute if data storage doom.ui:mixer data[{uid:$(uid)}].content[19].text if data storage doom.ui:ctx _.tr.$(uid).extra[0] run data modify storage doom.ui:ctx _.tr.$(uid).extra append from storage doom.ui:ctx _.sep_data
$execute if data storage doom.ui:mixer data[{uid:$(uid)}].content[19].text if data storage doom.ui:ctx _.tr.$(uid).extra[0] run data remove storage doom.ui:ctx _.sep_data
$execute if data storage doom.ui:mixer data[{uid:$(uid)}].content[19].text run data modify storage doom.ui:ctx _.tr.$(uid).extra append from storage doom.ui:mixer data[{uid:$(uid)}].content[19].text
