class_name GameState extends State

signal state_finished(state_outcome: GameOutcome)

var state_name: Game.StateName
var game: Game
var processing_done: Dictionary = {}

func wait_process(_delta: float) -> State:
	if state_processing:
		pass
	else:
		var state_outcome: GameOutcome = GameOutcome.new()
		state_finished.emit(state_outcome)
	return null


func pass_process(_delta: float) -> State:
	if state_processing:
		state_processing = false
	else:
		var state_outcome: GameOutcome = GameOutcome.new()
		state_finished.emit(state_outcome)
	return null


func _on_point_action_finished(point_state_outcome: PointOutcome) -> void:
	match point_state_outcome.action_name:
		Point.ActionName.END:
			pass
		_:
			pass
