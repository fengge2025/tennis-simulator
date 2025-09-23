class_name BallStateRun extends BallState

signal run_finished()

var moving: bool = false
var speed: float = 200.0

func enter() -> void:
	print("ball enter run")
	ball.update_animation("run")
	moving = true
	
func exit() -> void:
	moving = false

func process(delta: float) -> State:
	print("ball running")
	if moving:
		var direction = (ball.target_position - ball.position).normalized()
		var distance = ball.position.distance_to(ball.target_position)

		if distance > speed * delta:
			ball.position += direction * speed * delta
		else:
			ball.position = ball.target_position
			moving = false
	else:
		run_finished.emit()
	return null
