class_name BallState extends State

signal state_finished(state_outcome: BallOutcome)

var state_name: Ball.StateName
var ball: Ball

func wait_process(_delta: float) -> State:
	if state_processing:
		pass
	else:
		var state_outcome: GameStateOutcome = GameStateOutcome.new()
		state_finished.emit(state_outcome)
	return null


func pass_process(_delta: float) -> State:
	if state_processing:
		state_processing = false
	else:
		var state_outcome: GameStateOutcome = GameStateOutcome.new()
		state_finished.emit(state_outcome)
	return null
