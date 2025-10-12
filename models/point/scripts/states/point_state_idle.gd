class_name PointStateIdle extends PointState

func enter() -> void:
	point.logger.log("point enter idle")
	state_processing = true

func exit() -> void:
	state_processing = false


func process(_delta: float) -> State:
	if state_processing:
		pass
	else:
		state_finished.emit()
	return null
