class_name PlayerStateHit extends PlayerState

signal hit_finished(desire_ball_position: Vector2)

@onready var animation_player: AnimationPlayer = $"../../AnimationPlayer"

var hitting: bool = false

func enter() -> void:
	print("player enter hit")
	hitting = true
	player.update_animation("hit")
	animation_player.play("hit")
	animation_player.animation_finished.connect(end_hit)
	
func exit() -> void:
	animation_player.animation_finished.disconnect(end_hit)
	hitting = false

func end_hit(_animation: String) -> void:
	print(123123)
	hitting = false
	hit_finished.emit(player.hit_desire_position())
