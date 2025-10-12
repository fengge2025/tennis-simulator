class_name PlayerStateRun extends PlayerState

var speed: float = 400.0

func enter() -> void:
	print("player enter run")
	player.update_animation("run")
	state_processing = true
	
func exit() -> void:
	state_processing = false

func process(delta: float) -> State:
	if state_processing:
		var direction = (player.target_position - player.position).normalized()
		var distance = player.position.distance_to(player.target_position)

		if distance > speed * delta:
			player.position += direction * speed * delta
		else:
			player.position = player.target_position
			state_processing = false
	else:
		var state_outcome = PlayerStateOutcome.run_outcome(player.current_action)
		state_finished.emit(state_outcome)
	return null
