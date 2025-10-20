class_name PlayerState extends State

signal state_finished(state_outcome: PlayerOutcome)

var state_name: Player.StateName
var player: Player


func process(_delta: float) -> State:
	if state_processing:
		pass
	else:
		var state_outcome: PlayerOutcome = PlayerOutcome.new()
		state_finished.emit(state_outcome)
	return null
