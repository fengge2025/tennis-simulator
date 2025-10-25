class_name PointStatePrepare extends PointState


func _ready() -> void:
	state_name = Point.StateName.PREPARE


func enter() -> void:
	point.logger.log("point enter prepare")
	state_processing = true

	processing_done = {
		"ball": false,
		Player.HomeOrAway.HOME: false,
		Player.HomeOrAway.AWAY: false,
		"banner": false,
	}

	point.ball.action_finished.connect(_on_ball_action_finished)
	point.receive_player.action_finished.connect(_on_player_action_finished)
	point.hit_player.action_finished.connect(_on_player_action_finished)
	point.banner.animation_finished.connect(_on_banner_animation_finished)

	point.ball.prepare_action(point.ball.get_prepare_target_position())
	point.hit_player.prepare_action(point.hit_player.get_prepare_target_position())
	point.receive_player.prepare_action(point.receive_player.get_prepare_target_position())
	point.banner.display_banner("start")

func reenter() -> void:
	point.logger.log("point reenter prepare")

	point.ball.action_finished.connect(_on_ball_action_finished)
	point.receive_player.action_finished.connect(_on_player_action_finished)
	point.hit_player.action_finished.connect(_on_player_action_finished)
	point.banner.animation_finished.connect(_on_banner_animation_finished)


func exit() -> void:
	state_processing = false

	point.ball.action_finished.disconnect(_on_ball_action_finished)
	point.receive_player.action_finished.disconnect(_on_player_action_finished)
	point.hit_player.action_finished.disconnect(_on_player_action_finished)
	point.banner.animation_finished.disconnect(_on_banner_animation_finished)


func process(_delta: float) -> State:
	if state_processing:
		if not false in processing_done.values():
			state_processing = false
			return null
	else:
		var state_outcome: PointOutcome = PointOutcome.state_prepare_outcome(
			point.current_action, state_name
		)
		state_finished.emit(state_outcome)
	return null
	
	
func _on_ball_action_finished(state_outcome: BallOutcome) -> void:
	match state_outcome.action_name:
		Ball.ActionName.PREPARE:
			processing_done["ball"] = true
		_:
			pass
			
func _on_player_action_finished(player_state_outcome: PlayerOutcome) -> void:
	match player_state_outcome.action_name:
		Player.ActionName.PREPARE:
			processing_done[player_state_outcome.home_or_away] = true
			pass
		_:
			pass

func _on_banner_animation_finished(_animation_name: String) -> void:
	processing_done["banner"] = true
