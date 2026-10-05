data remove storage doom.ui:ctx _
$data modify storage doom.ui:ctx _ set value $(with)
execute unless data storage doom.ui:ctx _.targets run data modify storage doom.ui:ctx _.targets set value "@s"
execute unless data storage doom.ui:ctx _.sound run data modify storage doom.ui:ctx _.sound set value "minecraft:entity.experience_orb.pickup"
execute unless data storage doom.ui:ctx _.source run data modify storage doom.ui:ctx _.source set value "master"
execute unless data storage doom.ui:ctx _.volume run data modify storage doom.ui:ctx _.volume set value 1.0
execute unless data storage doom.ui:ctx _.pitch run data modify storage doom.ui:ctx _.pitch set value 1.0
# 2026-09-28：source 是枚举字面量、volume 需 ≥0、pitch 需在 0..2（PlaySoundCommand.java），
# 非法值会让 entry 整批实例化失败 ⇒ 先进 entry_safe 做前置校验（不合规就干净地不播）。
function doom.ui:internal/sound/entry_safe with storage doom.ui:ctx _


