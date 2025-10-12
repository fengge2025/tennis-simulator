class_name PointStateHit extends PointState

func enter() -> void:
	point.logger.log("point enter hit")
	state_processing = true

	self.connect_on_state_finished()

	point.ball.run(Vector2(50, 350))

func exit() -> void:
	state_processing = false

	self.disconnect_on_state_finished()


func process(_delta: float) -> State:
	if state_processing:
		pass
	else:
		state_finished.emit()
	return null