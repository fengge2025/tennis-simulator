class_name PointStateHit extends PointState

func _ready() -> void:
	state_name = "hit"

func enter() -> void:
	point.logger.log("point enter hit")
	state_processing = true

	connect_on_state_finished()

	point.ball.run(Vector2(50, 350))

func exit() -> void:
	state_processing = false

	disconnect_on_state_finished()

func process(delta: float) -> State:
	return wait_process(delta)