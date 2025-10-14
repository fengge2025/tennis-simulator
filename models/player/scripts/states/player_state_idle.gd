class_name PlayerStateIdle extends PlayerState

@onready var animation_player: AnimationPlayer = $"../../AnimationPlayer"

func _ready() -> void:
	state_name = "idle"

func enter() -> void:
	player.logger.log("player enter idle")
	player.update_animation("idle")
	state_processing = true

func exit() -> void:
	state_processing = false
