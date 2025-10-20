class_name PlayerStateMachine extends StateMachine


func initialize(player: Player) -> void:
	for c in get_children():
		if c is State:
			c.player = player
			states[c.state_name] = c

	change_state(states[Player.StateName.IDLE])
	process_mode = Node.PROCESS_MODE_INHERIT
