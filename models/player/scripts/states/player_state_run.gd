class_name PlayerStateRun extends PlayerState

var speed: float = 800.0

func _ready() -> void:
	state_name = "run"

func enter() -> void:
	player.logger.log("player enter run")
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
		var state_outcome = PlayerStateOutcome.run_outcome(player.current_action, player.home_or_away)
		state_finished.emit(state_outcome)
	return null
