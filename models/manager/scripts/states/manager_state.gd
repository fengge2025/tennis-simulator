class_name ManagerState extends State

signal state_finished(state_outcome: ManagerOutcome)

var state_name: Manager.StateName
var manager: Manager
var processing_done: Dictionary = {}


func wait_process(_delta: float) -> State:
	if state_processing:
		pass
	else:
		var state_outcome: ManagerOutcome = ManagerOutcome.new()
		state_finished.emit(state_outcome)
	return null


func pass_process(_delta: float) -> State:
	if state_processing:
		state_processing = false
	else:
		var state_outcome: ManagerOutcome = ManagerOutcome.new()
		state_finished.emit(state_outcome)
	return null
