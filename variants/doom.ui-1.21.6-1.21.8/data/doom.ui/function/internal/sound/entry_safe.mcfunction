# doom.ui:internal/sound/entry_safe -- 参数前置校验后再播音
#
# 2026-09-28 源码依据（MC 1.21.6 PlaySoundCommand.java）：
#   · \`source\` 是逐值枚举的 literal（master/music/record/weather/block/hostile/neutral/player/ambient/voice）
#   · \`volume\`  FloatArgumentType.floatArg(0.0F)        ⇒ 不能为负
#   · \`pitch\`   FloatArgumentType.floatArg(0.0F, 2.0F)  ⇒ 必须在 0..2
#   非法值不是运行期失败而是**解析期**失败；entry 是宏函数（整批实例化）⇒ 一次越界就让整次播音静默消失。
#   这里用「score 放大 100 倍」做范围判定（计分板没有浮点，放大是最省事的整数化手段），
#   越界 ⇒ 干净地什么都不做（与 bossbar 白名单一致的取舍）。
# 宏参数来自 doom.ui:ctx _：sound / source / volume / pitch / targets
$execute unless data storage doom.ui:ctx const.sources."$(source)" run return 0
execute store result score #_vol dt.temp run data get storage doom.ui:ctx _.volume 100
execute if score #_vol dt.temp matches ..-1 run return 0
execute store result score #_pit dt.temp run data get storage doom.ui:ctx _.pitch 100
execute if score #_pit dt.temp matches ..-1 run return 0
execute if score #_pit dt.temp matches 201.. run return 0
function doom.ui:internal/sound/entry with storage doom.ui:ctx _
