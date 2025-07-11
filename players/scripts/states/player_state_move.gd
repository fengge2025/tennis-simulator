class_name PlayerStateMove extends PlayerState

@onready var player_state_hit: PlayerStateHit = $"../PlayerStateHit"

var moving: bool = false
var target_position: Vector2 = Vector2.ZERO
var speed: float = 200.0

func Enter() -> void:
	player.UpdateAnimation("hit")
	
	moving = true
	
func Exit() -> void:
	moving = false
	
func Process(delta: float) -> State:
	if moving:
		var direction = (target_position - player.position).normalized()
		var distance = player.position.distance_to(target_position)
		print("=======")
		print(target_position)
		print(direction)
		print(distance)

		if distance > speed * delta:
			player.position += direction * speed * delta
		else:
			player.position = target_position
			moving = false
		return null
	else:
		return player_state_hit
	
func Physics(_delta: float) -> State:
	return null
	
func HandleInput(_event: InputEvent) -> State:
	return null

func EndHit(_newAnimName: String) -> void:
	moving = false
