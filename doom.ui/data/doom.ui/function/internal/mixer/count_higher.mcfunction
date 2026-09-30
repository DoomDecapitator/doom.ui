# doom.ui:internal/mixer/count_higher -- 统计 _.scan 中 priority **严格大于** #_p 的元素个数 → #_ins
# 调用：function doom.ui:internal/mixer/count_higher with storage doom.ui:ctx _
#   前置：_.scan = 段列表；#_p = 新段的 priority
# 本函数不含宏变量（槽位是字面量），所以**所有行都不该有 $ 前缀**。
#
# 为什么不用 data get 的过滤器数匹配（旧版的错）：
#   实测（2026-09-11，探针 A8）—— data get storage <id> <路径>[{k:v}] 返回的是
#   **解析到的那个 tag 的大小**（compound = 键数），不是匹配数。
#   段的结构 {id,priority,text,type} 有 4 个键 → 1 个匹配读成 4 → 插入位置算成 4，
#   超出列表长度后被 MC 夹到末尾，低优先级段就排到了末尾而不是中间。
#   实测后果：按 10 → 30 → 20 插入会排出 [CCC, AAA, BBB] 而不是 [CCC, BBB, AAA]。
#   只能逐元素比对。
#
# ⚠ #_ins 必须由本函数自己清零：调用方（set_segment / update_segment）已经不再清它。
#   2026-09-11 实测教训 —— 漏掉这一句会让 #_ins **一路累加**，插入位置越界被 MC 夹到末尾，
#   段就按创建顺序排列（升序），而不是按 priority。当时的测试恰好因为 #_ins 初始为 0 而通过，
#   所以在任何"脏"状态下都会失败。
scoreboard players set #_ins dt.temp 0
execute if data storage doom.ui:ctx _.scan[0] run scoreboard players set #_t dt.temp -1
execute if data storage doom.ui:ctx _.scan[0] run execute store result score #_t dt.temp run data get storage doom.ui:ctx _.scan[0].priority
execute if data storage doom.ui:ctx _.scan[0] run execute if score #_t dt.temp > #_p dt.temp run scoreboard players add #_ins dt.temp 1
execute if data storage doom.ui:ctx _.scan[1] run scoreboard players set #_t dt.temp -1
execute if data storage doom.ui:ctx _.scan[1] run execute store result score #_t dt.temp run data get storage doom.ui:ctx _.scan[1].priority
execute if data storage doom.ui:ctx _.scan[1] run execute if score #_t dt.temp > #_p dt.temp run scoreboard players add #_ins dt.temp 1
execute if data storage doom.ui:ctx _.scan[2] run scoreboard players set #_t dt.temp -1
execute if data storage doom.ui:ctx _.scan[2] run execute store result score #_t dt.temp run data get storage doom.ui:ctx _.scan[2].priority
execute if data storage doom.ui:ctx _.scan[2] run execute if score #_t dt.temp > #_p dt.temp run scoreboard players add #_ins dt.temp 1
execute if data storage doom.ui:ctx _.scan[3] run scoreboard players set #_t dt.temp -1
execute if data storage doom.ui:ctx _.scan[3] run execute store result score #_t dt.temp run data get storage doom.ui:ctx _.scan[3].priority
execute if data storage doom.ui:ctx _.scan[3] run execute if score #_t dt.temp > #_p dt.temp run scoreboard players add #_ins dt.temp 1
execute if data storage doom.ui:ctx _.scan[4] run scoreboard players set #_t dt.temp -1
execute if data storage doom.ui:ctx _.scan[4] run execute store result score #_t dt.temp run data get storage doom.ui:ctx _.scan[4].priority
execute if data storage doom.ui:ctx _.scan[4] run execute if score #_t dt.temp > #_p dt.temp run scoreboard players add #_ins dt.temp 1
execute if data storage doom.ui:ctx _.scan[5] run scoreboard players set #_t dt.temp -1
execute if data storage doom.ui:ctx _.scan[5] run execute store result score #_t dt.temp run data get storage doom.ui:ctx _.scan[5].priority
execute if data storage doom.ui:ctx _.scan[5] run execute if score #_t dt.temp > #_p dt.temp run scoreboard players add #_ins dt.temp 1
execute if data storage doom.ui:ctx _.scan[6] run scoreboard players set #_t dt.temp -1
execute if data storage doom.ui:ctx _.scan[6] run execute store result score #_t dt.temp run data get storage doom.ui:ctx _.scan[6].priority
execute if data storage doom.ui:ctx _.scan[6] run execute if score #_t dt.temp > #_p dt.temp run scoreboard players add #_ins dt.temp 1
execute if data storage doom.ui:ctx _.scan[7] run scoreboard players set #_t dt.temp -1
execute if data storage doom.ui:ctx _.scan[7] run execute store result score #_t dt.temp run data get storage doom.ui:ctx _.scan[7].priority
execute if data storage doom.ui:ctx _.scan[7] run execute if score #_t dt.temp > #_p dt.temp run scoreboard players add #_ins dt.temp 1
execute if data storage doom.ui:ctx _.scan[8] run scoreboard players set #_t dt.temp -1
execute if data storage doom.ui:ctx _.scan[8] run execute store result score #_t dt.temp run data get storage doom.ui:ctx _.scan[8].priority
execute if data storage doom.ui:ctx _.scan[8] run execute if score #_t dt.temp > #_p dt.temp run scoreboard players add #_ins dt.temp 1
execute if data storage doom.ui:ctx _.scan[9] run scoreboard players set #_t dt.temp -1
execute if data storage doom.ui:ctx _.scan[9] run execute store result score #_t dt.temp run data get storage doom.ui:ctx _.scan[9].priority
execute if data storage doom.ui:ctx _.scan[9] run execute if score #_t dt.temp > #_p dt.temp run scoreboard players add #_ins dt.temp 1
execute if data storage doom.ui:ctx _.scan[10] run scoreboard players set #_t dt.temp -1
execute if data storage doom.ui:ctx _.scan[10] run execute store result score #_t dt.temp run data get storage doom.ui:ctx _.scan[10].priority
execute if data storage doom.ui:ctx _.scan[10] run execute if score #_t dt.temp > #_p dt.temp run scoreboard players add #_ins dt.temp 1
execute if data storage doom.ui:ctx _.scan[11] run scoreboard players set #_t dt.temp -1
execute if data storage doom.ui:ctx _.scan[11] run execute store result score #_t dt.temp run data get storage doom.ui:ctx _.scan[11].priority
execute if data storage doom.ui:ctx _.scan[11] run execute if score #_t dt.temp > #_p dt.temp run scoreboard players add #_ins dt.temp 1
execute if data storage doom.ui:ctx _.scan[12] run scoreboard players set #_t dt.temp -1
execute if data storage doom.ui:ctx _.scan[12] run execute store result score #_t dt.temp run data get storage doom.ui:ctx _.scan[12].priority
execute if data storage doom.ui:ctx _.scan[12] run execute if score #_t dt.temp > #_p dt.temp run scoreboard players add #_ins dt.temp 1
execute if data storage doom.ui:ctx _.scan[13] run scoreboard players set #_t dt.temp -1
execute if data storage doom.ui:ctx _.scan[13] run execute store result score #_t dt.temp run data get storage doom.ui:ctx _.scan[13].priority
execute if data storage doom.ui:ctx _.scan[13] run execute if score #_t dt.temp > #_p dt.temp run scoreboard players add #_ins dt.temp 1
execute if data storage doom.ui:ctx _.scan[14] run scoreboard players set #_t dt.temp -1
execute if data storage doom.ui:ctx _.scan[14] run execute store result score #_t dt.temp run data get storage doom.ui:ctx _.scan[14].priority
execute if data storage doom.ui:ctx _.scan[14] run execute if score #_t dt.temp > #_p dt.temp run scoreboard players add #_ins dt.temp 1
execute if data storage doom.ui:ctx _.scan[15] run scoreboard players set #_t dt.temp -1
execute if data storage doom.ui:ctx _.scan[15] run execute store result score #_t dt.temp run data get storage doom.ui:ctx _.scan[15].priority
execute if data storage doom.ui:ctx _.scan[15] run execute if score #_t dt.temp > #_p dt.temp run scoreboard players add #_ins dt.temp 1
execute if data storage doom.ui:ctx _.scan[16] run scoreboard players set #_t dt.temp -1
execute if data storage doom.ui:ctx _.scan[16] run execute store result score #_t dt.temp run data get storage doom.ui:ctx _.scan[16].priority
execute if data storage doom.ui:ctx _.scan[16] run execute if score #_t dt.temp > #_p dt.temp run scoreboard players add #_ins dt.temp 1
execute if data storage doom.ui:ctx _.scan[17] run scoreboard players set #_t dt.temp -1
execute if data storage doom.ui:ctx _.scan[17] run execute store result score #_t dt.temp run data get storage doom.ui:ctx _.scan[17].priority
execute if data storage doom.ui:ctx _.scan[17] run execute if score #_t dt.temp > #_p dt.temp run scoreboard players add #_ins dt.temp 1
execute if data storage doom.ui:ctx _.scan[18] run scoreboard players set #_t dt.temp -1
execute if data storage doom.ui:ctx _.scan[18] run execute store result score #_t dt.temp run data get storage doom.ui:ctx _.scan[18].priority
execute if data storage doom.ui:ctx _.scan[18] run execute if score #_t dt.temp > #_p dt.temp run scoreboard players add #_ins dt.temp 1
execute if data storage doom.ui:ctx _.scan[19] run scoreboard players set #_t dt.temp -1
execute if data storage doom.ui:ctx _.scan[19] run execute store result score #_t dt.temp run data get storage doom.ui:ctx _.scan[19].priority
execute if data storage doom.ui:ctx _.scan[19] run execute if score #_t dt.temp > #_p dt.temp run scoreboard players add #_ins dt.temp 1
