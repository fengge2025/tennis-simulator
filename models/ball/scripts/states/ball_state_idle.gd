class_name BallStateIdle extends BallState

func enter() -> void:
	print("ball enter idle")
	ball.update_animation("run")
	
func exit() -> void:
	pass

func process(delta: float) -> State:
	print("ball idling")
	return null
