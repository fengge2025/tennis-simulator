class_name PointAction extends Node2D

@onready var ball: Ball = $Ball
@onready var player_a: Player = $PlayerA
@onready var player_b: Player = $PlayerB

var hit_player: Player
var receive_player: Player

# point states
var player_a_stated: bool = false
var player_b_stated: bool = false
var ball_stated: bool = false
var point_started: bool = false

func _ready() -> void:
	player_a.hit_finished.connect(_player_hit_finished)
	player_b.hit_finished.connect(_player_hit_finished)
	player_a.start_run_finished.connect(_player_a_start_run_finished)
	player_b.start_run_finished.connect(_player_b_start_run_finished)
	ball.run_finished.connect(_ball_run_finished)
	ball.start_run_finished.connect(_ball_start_run_finished)
	
	start_point(player_a, player_b)

func _process(_delta: float) -> void:
	print("========== POINT NOT STARTED ==========")
	if _stated():
		print("========== POINT STARTED ==========")
		point_started = true
		ball.run(Vector2.ZERO)
	
func start_point(_hit_player: Player, _receive_player: Player) -> void:
	hit_player = _hit_player
	receive_player = _receive_player
	
	ball.start_point(Vector2(200, 200))
	player_a.start_point(Vector2(100, 100))
	player_b.start_point(Vector2(300, 300))

func _stated() -> bool:
	return player_a_stated and player_b_stated and ball_stated and not point_started

func _ball_run_finished(target_position: Vector2) -> void:
	receive_player.hit_and_run(target_position)
	
func _player_hit_finished(desire_ball_position: Vector2)-> void:
	ball.run(desire_ball_position)
	_swap_players()

func _player_a_start_run_finished() -> void:
	player_a_stated = true

func _player_b_start_run_finished() -> void:
	player_b_stated = true

func _ball_start_run_finished() -> void:
	ball_stated = true
	
func _swap_players():
	var temp: Player = hit_player
	hit_player = receive_player
	receive_player = temp
