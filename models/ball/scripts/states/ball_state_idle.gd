class_name BallStateIdle extends BallState


func _ready() -> void:
	state_name = Ball.StateName.IDLE


func enter() -> void:
	ball.logger.log("ball enter idle")
	ball.update_animation("run")
	state_processing = true


func reenter() -> void:
	ball.logger.log("ball reenter idle")


func exit() -> void:
	state_processing = false


func process(delta: float) -> State:
	return wait_process(delta)
