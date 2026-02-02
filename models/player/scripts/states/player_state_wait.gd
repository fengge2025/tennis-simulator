class_name PlayerStateWait extends PlayerState

@onready var animation_player: AnimationPlayer = $"../../AnimationPlayer"


func _ready() -> void:
	state_name = Player.StateName.WAIT


func enter() -> void:
	player.logger.log("player enter wait")
	player.update_animation("idle")
	state_processing = true


func reenter() -> void:
	player.logger.log("player reenter wait")


func exit() -> void:
	state_processing = false


func process(delta: float) -> State:
	return _wait_process(delta)
