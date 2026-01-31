class_name TennisSetStatePlay extends TennisSetState

#signal action_update_point_score(outcome: GameOutcome)
#signal action_update_game_score(outcome: GameOutcome)

func _ready() -> void:
	state_name = TennisSet.StateName.PLAY


func enter() -> void:
	tennis_set.logger.log("tennis set enter play")
	state_processing = true

	tennis_set.game.action_finished.connect(_on_game_action_finished)



	tennis_set.game.start_game_action()

func reenter() -> void:
	tennis_set.logger.log("tennis set reenter play")


func exit() -> void:
	state_processing = false

	tennis_set.game.action_finished.disconnect(_on_game_action_finished)

func process(delta: float) -> State:
	return wait_process(delta)


func _on_game_action_finished(game_outcome: GameOutcome) -> void:
	# print("tennis set play state - game action finished:", game_outcome.action_name)
	print("score: ", tennis_set.score._to_string())
	match game_outcome.action_name:
		Point.ActionName.END:
			# update game score and reset point score
			tennis_set.score.update_game(game_outcome.game_winner)

			# restart a next point
			print("new point")
			tennis_set.game.start_game_action()
		_:
			pass
