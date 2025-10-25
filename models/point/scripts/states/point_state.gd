class_name PointState extends State

signal state_finished(state_outcome: PointOutcome)

var state_name: Point.StateName
var point: Point
var processing_done: Dictionary = {}

func wait_process(_delta: float) -> State:
	if state_processing:
		pass
	else:
		var state_outcome: PointOutcome = PointOutcome.new()
		state_finished.emit(state_outcome)
	return null


func pass_process(_delta: float) -> State:
	if state_processing:
		state_processing = false
	else:
		var state_outcome: PointOutcome = PointOutcome.new()
		state_finished.emit(state_outcome)
	return null
