class_name BallState extends State

signal state_finished(state_outcome: BallStateOutcome)

var ball: Ball


func process(_delta: float) -> State:
	if state_processing:
		pass
	else:
		var state_outcome = BallStateOutcome.new()
		state_finished.emit(state_outcome)
	return null
