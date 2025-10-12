class_name PlayerStateHit extends PlayerState

func enter() -> void:
	print("player enter hit")
	state_processing = true
	player.update_animation("hit")
	
func exit() -> void:
	state_processing = false
