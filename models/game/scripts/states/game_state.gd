class_name GameState extends State

signal state_finished(state_outcome: GameStateOutcome)
var game: Game
var processing_done: Dictionary = {}

func connect_on_state_finished() -> void:
	game.point.state_finished.connect(_on_point_finished)

func disconnect_on_state_finished() -> void:
	pass

func wait_process(_delta: float) -> State:
	if state_processing:
		pass
	else:
		var state_outcome = GameStateOutcome.new()
		state_finished.emit(state_outcome)
	return null

func pass_process(_delta: float) -> State:
	if state_processing:
		state_processing = false
	else:
		var state_outcome = GameStateOutcome.new()
		state_finished.emit(state_outcome)
	return null

func _on_point_finished(point_state_outcome: PointStateOutcome) -> void:
	match point_state_outcome.action:
		Point.ACTION.END:
			pass
		_:
			pass
