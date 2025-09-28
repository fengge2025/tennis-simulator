extends Node

@onready var ball: Ball = $Ball
@onready var player: Player = $Player

func _ready() -> void:	
	player.hit_finished.connect(_player_hit_finished)
	ball.run_finished.connect(_ball_run_finished)
	
	ball.run(Vector2.ZERO)

func _ball_run_finished(target_position: Vector2) -> void:
	player.hit_and_run(target_position)
	
func _player_hit_finished(desire_ball_position: Vector2)-> void:
	ball.run(desire_ball_position)
