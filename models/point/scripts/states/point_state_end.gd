class_name PointStateEnd extends PointState

func enter() -> void:
	point.logger.log("point enter end")
	state_processing = true

func exit() -> void:
	state_processing = false


func process(_delta: float) -> State:
	if state_processing:
		state_processing = false
	else:
		state_finished.emit()
	return null
