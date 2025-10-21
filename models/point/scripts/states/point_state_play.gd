class_name PointStatePlay extends PointState

func _ready() -> void:
	state_name = Point.StateName.PLAY


func enter() -> void:
	point.logger.log("point enter play")
	state_processing = true

	connect_on_state_finished()

	point.ball.run_action(point.receive_player.get_prepare_target_position())

func reenter() -> void:
	point.logger.log("point reenter play")

	connect_on_state_finished()


func exit() -> void:
	state_processing = false

	disconnect_on_state_finished()


func process(delta: float) -> State:
	return wait_process(delta)
	
func _on_ball_action_finished(state_outcome: BallOutcome) -> void:
	match state_outcome.action_name:
		Ball.ActionName.RUN:
			point.receive_player.hit_and_run_action(state_outcome.ball_destination_position)
		_:
			pass
			
			
func _on_player_action_finished(player_state_outcome: PlayerOutcome) -> void:
	match player_state_outcome.action_name:
		Player.ActionName.HIT_AND_RUN:
			match player_state_outcome.hit_result:
				PlayerHit.HitResult.HIT:
					point.ball.run_action(player_state_outcome.ball_destination_position)
					_swap_players()
				PlayerHit.HitResult.MISS:
					# var state_outcome: PointOutcome = PointOutcome.hit_outcome(
					# 	point.current_action,
					# 	player_scored_mapping[player_state_outcome.home_or_away]
					# )
					# state_finished.emit(state_outcome)
					print("miss")
					pass
				_:
					pass
		_:
			pass
