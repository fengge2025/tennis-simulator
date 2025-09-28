class_name BallRunAction extends Node2D

signal ball_run_finished(ball_destination_position: Vector2)

@onready var ball: Ball = $Ball

func ball_run(target_position: Vector2) -> void:
	ball.target_position = target_position
	ball.ball_state_machine.change_to('run')
	
func _ready() -> void:
	ball.ball_state_machine.states['run'].run_finished.connect(_run_finished)
	
func _run_finished(ball_destination_position: Vector2) -> void:
	ball.ball_state_machine.change_to('idle')
	ball_run_finished.emit(ball_destination_position)
