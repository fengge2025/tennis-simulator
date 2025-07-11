class_name PlayerStateHit extends PlayerState

@onready var player_state_idle: PlayerStateIdle = $"../PlayerStateIdle"
@onready var animation_player: AnimationPlayer = $"../../AnimationPlayer"

var hitting: bool = false

func Enter() -> void:
	player.UpdateAnimation("hit")
	animation_player.play("hit")
	animation_player.animation_finished.connect(EndHit)
	
	hitting = true
	
func Exit() -> void:
	hitting = false
	
func Process(_delta: float) -> State:
	if hitting == false:
		return player_state_idle
	return null
	
func Physics(_delta: float) -> State:
	return null
	
func HandleInput(_event: InputEvent) -> State:
	return null

func EndHit(_newAnimName: String) -> void:
	hitting = false
