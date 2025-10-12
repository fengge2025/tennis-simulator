class_name PlayerState extends State

signal state_finished(state_outcome: PlayerStateOutcome)

var player: Player

func process(_delta: float) -> State:
	if state_processing:
		pass
	else:
		var state_outcome = PlayerStateOutcome.new()
		state_finished.emit(state_outcome)
	return null