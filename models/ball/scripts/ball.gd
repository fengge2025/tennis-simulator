class_name Ball extends Node2D

@onready var ball_state_machine: BallStateMachine = $BallStateMachine
@onready var animation_player: AnimationPlayer = $AnimationPlayer

var target_position: Vector2 = Vector2.ZERO

func _ready() -> void:
	ball_state_machine.initialize(self)
	pass

func _process(_delta: float) -> void:
	pass

func update_animation( animation: String) -> void:
	animation_player.play(animation)
