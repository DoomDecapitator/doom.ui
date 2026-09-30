$bossbar remove doom.ui:bb_$(sid)
$data remove storage doom.ui:ctx sessions.bb_$(sid)
$data remove storage doom.ui:ctx active_bossbars[{sid: $(sid)}]
$data remove storage doom.ui:ctx bossbars[{bid:"$(bid)"}]
$data remove storage doom.ui:ctx bb_index."$(bid)"

