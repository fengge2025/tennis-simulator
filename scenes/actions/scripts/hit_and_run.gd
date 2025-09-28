class_name HitAndRun extends Node2D

signal hit_finished(desire_ball_position: Vector2)

@onready var player: Player = $Player

var target_position: Vector2 = Vector2.ZERO

var config_territory: Dictionary = {
	"hit_x_min": 100,
	"hit_x_max": 300,
	"hit_y_min": 100,
	"hit_y_max": 300
}

func _ready() -> void:
	target_position = get_temp_target_position()
	player.player_state_machine.states['run'].run_finished.connect(player_run_finished)
	player.player_state_machine.states['hit'].hit_finished.connect(player_hit_finished)
	
func hit_and_run(target_position: Vector2) -> void:
	player.target_position = target_position
	player.player_state_machine.change_to('run')
	
		
func get_temp_target_position() -> Vector2:
	var rand_vec = Vector2(
		randf_range(config_territory["hit_x_min"], config_territory["hit_x_max"]),
		randf_range(config_territory["hit_y_min"], config_territory["hit_y_max"])
	)
	print(rand_vec)
	return rand_vec
	
func player_run_finished() -> void:
	player.player_state_machine.change_to('hit')

func player_hit_finished(desire_ball_position: Vector2) -> void:
	print(desire_ball_position)
	player.player_state_machine.change_to('idle')
	hit_finished.emit(desire_ball_position)
