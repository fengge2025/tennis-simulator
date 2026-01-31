class_name GameStatePlay extends GameState

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


func _on_point_action_finished(point_outcome: PointOutcome) -> void:
	match point_outcome.action_name:
		Point.ActionName.END:
			print("point score: ", point_outcome.score_home_or_away)
			var is_game_ended: bool = game.score.update_point(point_outcome.score_home_or_away)
			print("home:away -- ", game.score.home_points, ":", game.score.away_points)
			print("_on_end_state_finished: gamed ended?", is_game_ended)
			if is_game_ended:
				var game_winner: Player.HomeOrAway = game.score.get_game_winner()
				print("game_state_play.gd game_winner: ", game_winner)
				var state_outcome: GameOutcome = GameOutcome.state_play_outcome(
					game.current_action, state_name, game_winner
				)
				state_finished.emit(state_outcome)
			else:
				game.point.start_point_action()
		_:
			pass
