class_name TennisSetStateMachine extends StateMachine


func initialize(tennis_set: TennisSet) -> void:
	for c in get_children():
		if c is State:
			c.tennis_set = tennis_set
			states[c.state_name] = c

	change_state(states["idle"])
	process_mode = Node.PROCESS_MODE_INHERIT
