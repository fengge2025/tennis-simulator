extends Node

@onready var player: Player = $Player
@onready var ball: Ball = $Ball

func _ready() -> void:
	player.target_position = Vector2(100, 100)
	player.player_state_machine.change_to('run')
	
	ball.target_position = Vector2(200, 200)
	ball.ball_state_machine.change_to('run')
