# doom.ui:internal/clear_player_cd -- remove countdown data for a specific uid (FIXED)
$data remove storage doom.ui:ctx sessions.cd_$(uid)
$data remove storage doom.ui:mixer data[{uid:$(uid)}].content[{type:"cd"}]
