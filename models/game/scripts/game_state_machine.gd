class_name GameStateMachine extends StateMachine


func initialize(game: Game) -> void:
	for c in get_children():
		if c is State:
			c.game = game
			states[c.state_name] = c

	change_state(states["idle"])
	process_mode = Node.PROCESS_MODE_INHERIT
