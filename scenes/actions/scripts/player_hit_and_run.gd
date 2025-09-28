class_name PlayerHitAndRunAction extends Node2D

signal player_hit_finished(desire_ball_position: Vector2)

@onready var player: Player = $Player

func player_hit_and_run(target_position: Vector2) -> void:
	player.target_position = target_position
	player.player_state_machine.change_to('run')

func _ready() -> void:
	player.player_state_machine.states['run'].run_finished.connect(_player_run_finished)
	player.player_state_machine.states['hit'].hit_finished.connect(_player_hit_finished)
	
func _player_run_finished() -> void:
	player.player_state_machine.change_to('hit')

func _player_hit_finished(desire_ball_position: Vector2) -> void:
	print(desire_ball_position)
	player.player_state_machine.change_to('idle')
	player_hit_finished.emit(desire_ball_position)
