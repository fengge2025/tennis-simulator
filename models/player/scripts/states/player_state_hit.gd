class_name PlayerStateHit extends PlayerState


func _ready() -> void:
	state_name = Player.StateName.HIT


func enter() -> void:
	player.logger.log("player enter hit")
	state_processing = true
	player.update_animation("hit")


func reenter() -> void:
	player.logger.log("player reenter hit")


func exit() -> void:
	state_processing = false
