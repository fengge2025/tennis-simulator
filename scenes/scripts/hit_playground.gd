extends Node

@onready var ball_run_action: BallRunAction = $BallRunAction
@onready var player_hit_and_run_action: PlayerHitAndRunAction = $PlayerHitAndRunAction

func _ready() -> void:	
	player_hit_and_run_action.player_hit_finished.connect(_player_hit_and_run_finished)
	ball_run_action.ball_run_finished.connect(_ball_run_finished)
	
	ball_run_action.ball_run(Vector2.ZERO)

func _ball_run_finished(target_position: Vector2) -> void:
	player_hit_and_run_action.player_hit_and_run(target_position)
	
func _player_hit_and_run_finished(desire_ball_position: Vector2)-> void:
	ball_run_action.ball_run(desire_ball_position)
