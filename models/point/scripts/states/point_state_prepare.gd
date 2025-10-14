class_name PointStatePrepare extends PointState


func _ready() -> void:
	state_name = "prepare"


func enter() -> void:
	point.logger.log("point enter prepare")
	state_processing = true

	processing_done = {
		"ball": false,
		"home_player": false,
		"away_player": false,
		"banner": false,
	}

	self.connect_on_state_finished()

	point.ball.prepare(Vector2(200, 200))
	point.hit_player.prepare(Vector2(100, 100))
	point.receive_player.prepare(Vector2(300, 300))
	point.banner.display_banner("start")


func exit() -> void:
	state_processing = false

	self.disconnect_on_state_finished()


func process(_delta: float) -> State:
	if state_processing:
		if not false in processing_done.values():
			state_processing = false
	else:
		var state_outcome = PointStateOutcome.prepare_outcome(point.current_action)
		state_finished.emit(state_outcome)
	return null
