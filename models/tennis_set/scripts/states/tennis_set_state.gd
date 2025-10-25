class_name TennisSetState extends State

signal state_finished(state_outcome: TennisSetStateOutcome)

var tennis_set: TennisSet
var processing_done: Dictionary = {}

func wait_process(_delta: float) -> State:
	if state_processing:
		pass
	else:
		var state_outcome: TennisSetStateOutcome = TennisSetStateOutcome.new()
		state_finished.emit(state_outcome)
	return null


func pass_process(_delta: float) -> State:
	if state_processing:
		state_processing = false
	else:
		var state_outcome: TennisSetStateOutcome = TennisSetStateOutcome.new()
		state_finished.emit(state_outcome)
	return null
