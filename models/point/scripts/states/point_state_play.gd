class_name PointStatePlay extends PointState

func _ready() -> void:
	state_name = Point.StateName.PLAY


func enter() -> void:
	point.logger.log("point enter play")
	state_processing = true

	point.ball.action_finished.connect(_on_ball_action_finished)
	point.receive_player.action_finished.connect(_on_player_action_finished)
	point.hit_player.action_finished.connect(_on_player_action_finished)

	point.ball.run_action(point.receive_player.get_prepare_target_position())

func reenter() -> void:
	point.logger.log("point reenter play")

	point.ball.action_finished.connect(_on_ball_action_finished)
	point.receive_player.action_finished.connect(_on_player_action_finished)
	point.hit_player.action_finished.connect(_on_player_action_finished)



func exit() -> void:
	state_processing = false

	point.ball.action_finished.disconnect(_on_ball_action_finished)
	point.receive_player.action_finished.disconnect(_on_player_action_finished)
	point.hit_player.action_finished.disconnect(_on_player_action_finished)


func process(delta: float) -> State:
	return wait_process(delta)
	
func _on_ball_action_finished(state_outcome: BallOutcome) -> void:
	match state_outcome.action_name:
		Ball.ActionName.RUN:
			point.receive_player.hit_and_run_action(state_outcome.ball_destination_position)
		_:
			pass
			
			
func _on_player_action_finished(player_outcome: PlayerOutcome) -> void:
	match player_outcome.action_name:
		Player.ActionName.HIT_AND_RUN:
			match player_outcome.hit_result:
				PlayerHit.HitResult.HIT:
					point.ball.run_action(player_outcome.ball_destination_position)
					_swap_players()
				PlayerHit.HitResult.MISS:
					print(player_outcome.home_or_away, " miss")
					var score_home_or_away: Player.HomeOrAway = Point.get_score_player_home_or_away(player_outcome.home_or_away)
					print(score_home_or_away, " score")
					point.score_home_or_away = score_home_or_away
					var state_outcome: PointOutcome = PointOutcome.state_play_outcome(
						point.current_action,
						state_name
					)
					state_finished.emit(state_outcome)
				_:
					pass
		_:
			pass

func _swap_players() -> void:
	point.receive_turn ^= 1