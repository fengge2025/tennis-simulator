extends Node

@onready var ball: Ball = $Ball

func _ready() -> void:
	ball.target_position = Vector2(100, 100)
	ball.ball_state_machine.change_to('run')
