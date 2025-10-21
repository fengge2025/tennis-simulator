class_name PointStateEnd extends PointState

func _ready() -> void:
	state_name = Point.StateName.END

func enter() -> void:
	point.logger.log("point enter end")
	state_processing = true

func reenter() -> void:
	point.logger.log("point reenter end")

func exit() -> void:
	state_processing = false


func process(_delta: float) -> State:
	if state_processing:
		state_processing = false
	else:
		# var state_outcome: PointOutcome = PointOutcome.end_outcome(
		# 	point.current_action, point.score_home_or_away
		# )
		# state_finished.emit(state_outcome)
		pass
	return null
