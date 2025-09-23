class_name PlayerStateIdle extends PlayerState

@onready var animation_player: AnimationPlayer = $"../../AnimationPlayer"

var waiting = false

func enter() -> void:
	print("player enter idle")
	player.update_animation("idle")
	waiting = true

func exit() -> void:
	waiting = false
