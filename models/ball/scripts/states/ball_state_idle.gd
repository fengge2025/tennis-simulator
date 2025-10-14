class_name BallStateIdle extends BallState


func enter() -> void:
	ball.logger.log("ball enter idle")
	ball.update_animation("run")
	state_processing = true


func exit() -> void:
	state_processing = false


func process(_delta: float) -> State:
	return null
