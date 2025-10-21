class_name PointStateMachine extends StateMachine


func initialize(point: Point) -> void:
	for c in get_children():
		if c is State:
			c.point = point
			states[c.state_name] = c

	change_state(states[Point.StateName.IDLE])
	process_mode = Node.PROCESS_MODE_INHERIT
