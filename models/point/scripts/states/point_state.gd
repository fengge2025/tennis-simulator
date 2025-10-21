class_name PointState extends State

signal state_finished(state_outcome: PointOutcome)

var state_name: Point.StateName
var point: Point
var processing_done: Dictionary = {}

var player_scored_mapping: Dictionary = {
	"away": "home",
	"home": "away",
}


func connect_on_state_finished() -> void:
	point.ball.action_finished.connect(_on_ball_action_finished)
	point.receive_player.action_finished.connect(_on_player_action_finished)
	point.hit_player.action_finished.connect(_on_player_action_finished)
	point.banner.animation_finished.connect(_on_banner_animation_finished)


func disconnect_on_state_finished() -> void:
	point.ball.action_finished.disconnect(_on_ball_action_finished)
	point.receive_player.action_finished.disconnect(_on_player_action_finished)
	point.hit_player.action_finished.disconnect(_on_player_action_finished)
	point.banner.animation_finished.disconnect(_on_banner_animation_finished)


func wait_process(_delta: float) -> State:
	if state_processing:
		pass
	else:
		var state_outcome: PointOutcome = PointOutcome.new()
		state_finished.emit(state_outcome)
	return null


func pass_process(_delta: float) -> State:
	if state_processing:
		state_processing = false
	else:
		var state_outcome: PointOutcome = PointOutcome.new()
		state_finished.emit(state_outcome)
	return null


func _on_ball_action_finished(state_outcome: BallOutcome) -> void:
	match state_outcome.action_name:
		Ball.ActionName.PREPARE:
			#processing_done["ball"] = true
			pass
		Ball.ActionName.RUN:
			#point.receive_player.hit_and_run(state_outcome.ball_destination_position)
			pass
		_:
			pass


func _on_player_action_finished(player_state_outcome: PlayerOutcome) -> void:
	match player_state_outcome.action_name:
		Player.ActionName.PREPARE:
			#processing_done[player_state_outcome.home_or_away] = true
			pass
		Player.ActionName.HIT_AND_RUN:
			match player_state_outcome.hit_result:
				PlayerHit.HitResult.HIT:
					#point.ball.run(player_state_outcome.desire_ball_position)
					#_swap_players()
					pass
				PlayerHit.HitResult.MISS:
					# var state_outcome: PointOutcome = PointOutcome.hit_outcome(
					# 	point.current_action,
					# 	player_scored_mapping[player_state_outcome.home_or_away]
					# )
					# state_finished.emit(state_outcome)
					pass
				_:
					pass
		_:
			pass


func _on_banner_animation_finished(_animation_name: String) -> void:
	#processing_done["banner"] = true
	pass


func _swap_players() -> void:
	point.receive_turn ^= 1
