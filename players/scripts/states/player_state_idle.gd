class_name PlayerStateIdle extends PlayerState

@onready var player_state_move: PlayerStateMove = $"../PlayerStateMove"

func Enter() -> void:
	player.UpdateAnimation("idle")

func Exit() -> void:
	pass
	
func Process(_delta: float) -> State:
	var rand_vec = Vector2(
		randf_range(100, 400),
		randf_range(100, 400)
	)
	
	print(rand_vec)
	
	player_state_move.target_position = rand_vec
	return player_state_move
	
func Physics(_delta: float) -> State:
	return null
	
func HandleInput(_event: InputEvent) -> State:
	return null
