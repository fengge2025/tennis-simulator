extends Node

@onready var player: Player = $Player
@onready var ball: Ball = $Ball

var config_territory: Dictionary = {
	"hit_x_min": 100,
	"hit_x_max": 300,
	"hit_y_min": 100,
	"hit_y_max": 300
}
var target_position: Vector2 = Vector2.ZERO

func _ready() -> void:
	target_position = get_target_position()
	
	ball.ball_state_machine.states['run'].run_finished.connect(ball_run_finished)
	player.player_state_machine.states['run'].run_finished.connect(player_run_finished)
	player.player_state_machine.states['hit'].hit_finished.connect(player_hit_finished)
	
	ball.target_position = target_position
	ball.ball_state_machine.change_to('run')
	
	
		
func get_target_position() -> Vector2:
	var rand_vec = Vector2(
		randf_range(config_territory["hit_x_min"], config_territory["hit_x_max"]),
		randf_range(config_territory["hit_y_min"], config_territory["hit_y_max"])
	)
	print(rand_vec)
	return rand_vec


func ball_run_finished() -> void:
	player.target_position = target_position
	player.player_state_machine.change_to('run')
	
	ball.ball_state_machine.change_to('idle')
	
func player_run_finished() -> void:
	player.player_state_machine.change_to('hit')

func player_hit_finished(_desire_ball_position: Vector2) -> void:
	print(_desire_ball_position)
	target_position = get_target_position()
	player.player_state_machine.change_to('idle')
	
	ball.target_position = target_position
	ball.ball_state_machine.change_to('run')
