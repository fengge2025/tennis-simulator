class_name PlayerStateHit extends PlayerState

signal hit_finished(hit_result: String, desire_ball_position: Vector2)

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
	
func _get_random_int() -> int:
	randomize() # ensures different result each time you run the game
	return randi_range(0, 100)
	
func _get_hit_result() -> String:
	if _get_random_int() > 30:
		return 'hit'
	else:
		return 'miss'

func end_hit(_animation: String) -> void:
	hitting = false
	
	var hit_result: String = _get_hit_result()
	
	hit_finished.emit(hit_result, player.hit_desire_position())
