class_name BallStateRun extends BallState

var speed: float = 200.0


func enter() -> void:
	ball.logger.log("ball enter run")
	ball.update_animation("run")
	state_processing = true


func exit() -> void:
	state_processing = false


func process(delta: float) -> State:
	if state_processing:
		var direction: Vector2 = (ball.target_position - ball.position).normalized()
		var distance: float = ball.position.distance_to(ball.target_position)

		if distance > speed * delta:
			ball.position += direction * speed * delta
		else:
			ball.position = ball.target_position
			state_processing = false
	else:
		var state_outcome: BallStateOutcome = BallStateOutcome.run_outcome(ball.current_action, ball.target_position)
		state_finished.emit(state_outcome)
	return null
