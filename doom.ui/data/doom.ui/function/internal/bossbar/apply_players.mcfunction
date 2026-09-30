# doom.ui:internal/bossbar/apply_players -- players 单独一层
#
# 2026-09-28：`bossbar set <id> players <targets>` 的参数是 EntityArgument.players()，
# 传非玩家选择器（如 @e[type=item]）是**解析期**错误 ⇒ 宏整批失败。
# 单列一层后，坏选择器只让"设置可见玩家"这一步失败，血条本体与注册表保持自洽（不再产生孤儿）。
$bossbar set doom.ui:bb_$(sid) players $(targets)
