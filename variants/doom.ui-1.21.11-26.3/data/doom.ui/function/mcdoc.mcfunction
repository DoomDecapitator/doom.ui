# mcdoc autocomplete examples - doom.ui
#
# ⚠ 警告：本文件是**给编辑器/mcdoc 看的示例**，里面的命令是真实可执行的。
#   不要 function doom.ui:mcdoc —— 那会真的往 doom.ui:ctx 里写数据。
#   这里只是为了 Spyglass / Misode 能对 {with:{...}} 补全。
#
# Install Spyglass or Misode's mcdoc plugin, then type `{` in commands below
# to trigger structure completion.

# === doom.ui:ctx ===

# with - API input parameters (actionbar/alert/flash/countdown/bossbar)
data merge storage doom.ui:ctx {with:{targets:"@a",content:{text:"hello"},time:100,slot:"default"}}
data merge storage doom.ui:ctx {with:{targets:"@a",title:{text:"BOSS"},subtitle:{text:"..."},fade_in:5,stay:100,fade_out:10}}
data merge storage doom.ui:ctx {with:{targets:"@a",count:5,interval:10,title:{text:"!"},subtitle:{text:""}}}
data merge storage doom.ui:ctx {with:{targets:"@a",seconds:60,prefix:{text:"Time"},slot:"countdown"}}
data merge storage doom.ui:ctx {with:{targets:"@a",name:{text:"Boss"},color:"red",style:"progress",time:100,bid:"default"}}
data merge storage doom.ui:ctx {with:{targets:"@a",content:{text:"msg"},on_fade:"say faded"}}
data merge storage doom.ui:ctx {with:{targets:"@a",sound:"minecraft:entity.experience_orb.pickup",source:"master",volume:1.0,pitch:1.0}}
data merge storage doom.ui:ctx {with:{targets:"@a",separator:{text:"|"}}}
data merge storage doom.ui:ctx {with:{targets:"@a",time:100}}

# === doom.ui:mixer ===

# mixer per-player data (read-only, managed by internal functions)
data get storage doom.ui:mixer data
