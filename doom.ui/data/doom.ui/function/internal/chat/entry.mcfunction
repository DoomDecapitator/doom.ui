# doom.ui:internal/chat/entry -- entry point for processing
$execute as $(targets) run tellraw @s $(content)
$execute if data storage doom.ui:ctx _.on_fade as $(targets) at @s run function doom.ui:internal/exec_on_fade with storage doom.ui:ctx _


