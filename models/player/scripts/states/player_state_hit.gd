class_name PlayerStateHit extends PlayerState


func _ready() -> void:
	state_name = "hit"


func enter() -> void:
	player.logger.log("player enter hit")
	state_processing = true
	player.update_animation("hit")


func exit() -> void:
	state_processing = false
