extends Node

@onready var ball: Ball = $Ball
@onready var player_a: Player = $PlayerA
@onready var player_b: Player = $PlayerB

var hit_player: Player
var receive_player: Player

func _ready() -> void:
	hit_player = player_a
	receive_player = player_b
	
	player_a.hit_finished.connect(_player_hit_finished)
	player_b.hit_finished.connect(_player_hit_finished)
	ball.run_finished.connect(_ball_run_finished)
	
	ball.run(Vector2.ZERO)

func _ball_run_finished(target_position: Vector2) -> void:
	receive_player.hit_and_run(target_position)
	
func _player_hit_finished(desire_ball_position: Vector2)-> void:
	ball.run(desire_ball_position)
	_swap_players()
	
func _swap_players():
	var temp: Player = hit_player
	hit_player = receive_player
	receive_player = temp
