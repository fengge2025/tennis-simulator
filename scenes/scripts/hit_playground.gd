extends Node

@onready var ball: Ball = $Ball
@onready var hit_and_run: HitAndRun = $HitAndRun

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
	hit_and_run.hit_finished.connect(hit_and_run_finished)
	
	ball.target_position = target_position
	ball.ball_state_machine.change_to('run')
	
	
		
func get_target_position() -> Vector2:
	var rand_vec = Vector2(
		randf_range(config_territory["hit_x_min"], config_territory["hit_x_max"]),
		randf_range(config_territory["hit_y_min"], config_territory["hit_y_max"])
	)
	print(rand_vec)
	return rand_vec


func ball_run_finished(target_position: Vector2) -> void:
	ball.ball_state_machine.change_to('idle')
	hit_and_run.hit_and_run(target_position)
	
func hit_and_run_finished(desire_ball_position: Vector2)-> void:
	ball.target_position = desire_ball_position
	ball.ball_state_machine.change_to('run')
