class_name PointState extends State

signal state_finished(state_outcome: PointStateOutcome)

var point: Point
var processing_done: Dictionary = {}

var player_scored_mapping = {
	"away": "home",
	"home": "away",
}


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


func wait_process(_delta: float) -> State:
	if state_processing:
		pass
	else:
		var state_outcome = PointStateOutcome.new()
		state_finished.emit(state_outcome)
	return null


func pass_process(_delta: float) -> State:
	if state_processing:
		state_processing = false
	else:
		var state_outcome = PointStateOutcome.new()
		state_finished.emit(state_outcome)
	return null


func _on_ball_state_finished(state_outcome: BallStateOutcome) -> void:
	match state_outcome.action:
		Ball.Action.PREPARE:
			processing_done["ball"] = true
		Ball.Action.RUN:
			point.receive_player.hit_and_run(state_outcome.ball_destination_position)
		_:
			pass


func _on_player_state_finished(player_state_outcome: PlayerStateOutcome) -> void:
	match player_state_outcome.action:
		Player.Action.PREPARE:
			processing_done["%s_player" % player_state_outcome.home_or_away] = true
		Player.Action.HIT_AND_RUN:
			match player_state_outcome.hit_result:
				PlayerHit.HIT_RESULT.HIT:
					point.ball.run(player_state_outcome.desire_ball_position)
					_swap_players()
				PlayerHit.HIT_RESULT.MISS:
					var state_outcome = PointStateOutcome.hit_outcome(
						point.current_action,
						player_scored_mapping[player_state_outcome.home_or_away]
					)
					state_finished.emit(state_outcome)
				_:
					pass
		_:
			pass


func _on_banner_animation_finished(_animation_name: String) -> void:
	processing_done["banner"] = true


func _swap_players():
	point.receive_turn ^= 1
