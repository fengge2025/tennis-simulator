class_name PointState extends State

signal state_finished()
var point: Point
var processing_done: Dictionary = {}

func connect_on_state_finished() -> void:
	point.ball.state_finished.connect(_on_ball_state_finished)
	point.receive_player.state_finished.connect(_on_player_state_finished)
	point.hit_player.state_finished.connect(_on_player_state_finished)
	point.banner.animation_finished.connect(_on_banner_animation_finished)

func disconnect_on_state_finished() -> void:
	point.ball.state_finished.disconnect(_on_ball_state_finished)
	point.receive_player.state_finished.disconnect(_on_player_state_finished)
	point.hit_player.state_finished.disconnect(_on_player_state_finished)
	point.banner.animation_finished.disconnect(_on_banner_animation_finished)

func process(_delta: float) -> State:
	if state_processing:
		pass
	else:
		state_finished.emit()
	return null

func _on_ball_state_finished(state_outcome: BallStateOutcome) -> void:
	match state_outcome.action:
		Ball.ACTION.PREPARE:
			processing_done["ball"] = true
		Ball.ACTION.RUN:
			point.receive_player.hit_and_run(state_outcome.ball_destination_position)
		_:
			pass

func _on_player_state_finished(state_outcome: PlayerStateOutcome) -> void:
	match state_outcome.action:
		Player.ACTION.PREPARE:
			processing_done["%s_player" % state_outcome.home_or_away] = true
		Player.ACTION.HIT_AND_RUN:
			match state_outcome.hit_result:
				PlayerHit.HIT_RESULT.HIT:
					point.ball.run(state_outcome.desire_ball_position)
					_swap_players()
				PlayerHit.HIT_RESULT.MISS:
					state_finished.emit()
				_:
					pass
		_:
			pass

func _on_banner_animation_finished(_animation_name: String) -> void:
	processing_done["banner"] = true

func _swap_players():
	point.receive_turn ^= 1
