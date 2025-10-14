class_name GameStatePlay extends GameState

signal update_score()

func _ready() -> void:
	state_name = "play"

func enter() -> void:
	game.logger.log("game enter play")
	state_processing = true

	connect_on_state_finished()

	game.point.start_point()

func exit() -> void:
	state_processing = false

	disconnect_on_state_finished()

func process(delta: float) -> State:
	return wait_process(delta)

func _on_point_finished(point_state_outcome: PointStateOutcome) -> void:
	match point_state_outcome.action:
		Point.ACTION.END:
			game.score.player_score(point_state_outcome.score_home_or_away)

			update_score.emit()

			# restart a next point
			game.point.start_point()
		_:
			pass