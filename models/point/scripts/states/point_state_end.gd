class_name PointStateEnd extends PointState

func _ready() -> void:
	state_name = "end"

func enter() -> void:
	point.logger.log("point enter end")
	state_processing = true

func exit() -> void:
	state_processing = false

func process(_delta: float) -> State:
	if state_processing:
		state_processing = false
	else:
		var state_outcome = PointStateOutcome.end_outcome(point.current_action, point.score_home_or_away)
		state_finished.emit(state_outcome)
	return null
