class_name PlayerStateHit extends PlayerState


func _ready() -> void:
	state_name = Player.StateName.HIT


func enter() -> void:
	player.logger.log("player enter hit")
	state_processing = true
	player.update_animation("hit")

	player.animation_player.animation_finished.connect(_on_animation_finished)


func reenter() -> void:
	player.logger.log("player reenter hit")
	player.animation_player.animation_finished.connect(_on_animation_finished)


func exit() -> void:
	state_processing = false
	player.animation_player.animation_finished.disconnect(_on_animation_finished)


func process(delta: float) -> State:
	return _wait_process(delta)


func _on_animation_finished(animation_name: String) -> void:
	if animation_name == "hit":
		state_processing = false

		var state_outcome: PlayerOutcome.PlayerStateHitOutcome = (
			PlayerOutcome.PlayerStateHitOutcome.new_hit_outcome()
		)
		state_finished.emit(state_outcome)
