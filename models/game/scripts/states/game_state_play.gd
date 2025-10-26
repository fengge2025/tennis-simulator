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
			#game.score.player_score(point_outcome.score_home_or_away)
			
			# should update score?

			# restart a next point
			game.point.start_point_action()
		_:
			pass
