class_name PlayerStateMachine extends StateMachine

func Initialize(player: RacketPlayer) -> void:
	states = []
	for c in get_children():
		if c is State:
			states.append(c)
			
	if states.size() > 0:
		states[0].player = player
		ChangeState( states[0] )
		process_mode = Node.PROCESS_MODE_INHERIT
