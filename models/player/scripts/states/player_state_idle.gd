class_name PlayerStateIdle extends PlayerState

@onready var animation_player: AnimationPlayer = $"../../AnimationPlayer"


func _ready() -> void:
	state_name = Player.StateName.IDLE


func enter() -> void:
	player.logger.log("player enter idle")
	player.update_animation("idle")
	state_processing = true


func reenter() -> void:
	player.logger.log("player reenter idle")


func exit() -> void:
	state_processing = false
