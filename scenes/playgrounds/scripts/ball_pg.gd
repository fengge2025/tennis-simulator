extends Node

@onready var ball: Ball = $Ball

func _ready() -> void:
	ball.action_finished.connect(_on_ball_action_finished)
	
	var v: Vector2 = Vector2(100, 100)
	ball.prepare_action(v)

func _on_ball_action_finished(outcome: BallOutcome) -> void:
	match outcome.action_name:
		Ball.ActionName.PREPARE:
			var vv: Vector2 = Vector2(350, 350)
			ball.run_action(vv)
		Ball.ActionName.RUN:
			ball.idle_action()
		_:
			push_error("no action _on_ball_action_finished")
