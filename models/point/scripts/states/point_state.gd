class_name PointState extends State

signal state_finished(state_outcome: PointOutcome.PointStateOutcome)

var state_name: Point.StateName
var point: Point
var processing_done: Dictionary = {}


func _wait_process(_delta: float) -> State:
	if state_processing:
		pass
	else:
		var state_outcome: PointOutcome.PointStateOutcome = (
			PointOutcome.PointStateOutcome.new_outcome(state_name, point.current_action)
		)
		state_finished.emit(state_outcome)
	return null


func _pass_process(_delta: float) -> State:
	if state_processing:
		state_processing = false
	else:
		var state_outcome: PointOutcome.PointStateOutcome = (
			PointOutcome.PointStateOutcome.new_outcome(state_name, point.current_action)
		)
		state_finished.emit(state_outcome)
	return null
