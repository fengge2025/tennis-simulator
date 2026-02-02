class_name PlayerState extends State

signal state_finished(state_outcome: PlayerOutcome.PlayerStateOutcome)

var state_name: Player.StateName
var player: Player


func _wait_process(_delta: float) -> State:
	if state_processing:
		pass
	else:
		var state_outcome: PlayerOutcome.PlayerStateOutcome = (
			PlayerOutcome.PlayerStateOutcome.new_outcome(state_name, player.current_action)
		)
		state_finished.emit(state_outcome)
	return null


func _pass_process(_delta: float) -> State:
	if state_processing:
		state_processing = false
	else:
		var state_outcome: PlayerOutcome.PlayerStateOutcome = (
			PlayerOutcome.PlayerStateOutcome.new_outcome(state_name, player.current_action)
		)
		state_finished.emit(state_outcome)
	return null
