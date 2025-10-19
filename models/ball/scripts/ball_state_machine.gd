class_name BallStateMachine extends StateMachine


func initialize(ball: Ball) -> void:
	for c in get_children():
		if c is State:
			c.ball = ball
			states[c.state_name] = c

	change_state(states[Ball.StateName.IDLE])
	process_mode = Node.PROCESS_MODE_INHERIT
