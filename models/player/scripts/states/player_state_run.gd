class_name PlayerStateRun extends PlayerState

var speed: float = 800.0


func _ready() -> void:
	state_name = Player.StateName.RUN


func enter() -> void:
	player.logger.log("player enter run")
	player.update_animation("run")
	state_processing = true


func reenter() -> void:
	player.logger.log("player reenter run")


func exit() -> void:
	state_processing = false


func process(delta: float) -> State:
	if state_processing:
		var direction: Vector2 = (player.target_position - player.position).normalized()
		var distance: float = player.position.distance_to(player.target_position)

		if distance > speed * delta:
			player.position += direction * speed * delta
		else:
			player.position = player.target_position
			state_processing = false
	else:
		var state_outcome: PlayerOutcome = PlayerOutcome.state_run_outcome(
			player.current_action, state_name, player.target_position
		)
		state_finished.emit(state_outcome)
	return null
