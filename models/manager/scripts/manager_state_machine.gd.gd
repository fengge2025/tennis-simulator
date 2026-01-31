class_name ManagerStateMachine extends StateMachine


func initialize(manager: Manager) -> void:
	for c in get_children():
		if c is State:
			c.manager = manager
			states[c.state_name] = c

	change_state(states[Manager.StateName.IDLE])
	process_mode = Node.PROCESS_MODE_INHERIT
