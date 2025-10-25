class_name GameStatePlay extends GameState

signal action_update_score(outcome: GameOutcome)

func _ready() -> void:
	state_name = Game.StateName.PLAY

func enter() -> void:
	game.logger.log("game enter play")
	state_processing = true

	game.point.action_finished.connect(_on_point_action_finished)

	game.point.start_point_action()

func reenter() -> void:
	game.logger.log("game reenter play")

func exit() -> void:
	state_processing = false

	game.point.action_finished.disconnect(_on_point_action_finished)


func process(delta: float) -> State:
	return wait_process(delta)


func _on_point_action_finished(point_state_outcome: PointOutcome) -> void:
	match point_state_outcome.action_name:
		Point.ActionName.END:
			print(point_state_outcome.score_home_or_away, " score")
			game.score.player_score(point_state_outcome.score_home_or_away)

			var outcome: GameOutcome = GameOutcome.action_play_update_score_outcome(game.current_action, game.score)
			action_update_score.emit(outcome)
			
			# restart a next point
			game.point.start_point_action()
		_:
			pass
