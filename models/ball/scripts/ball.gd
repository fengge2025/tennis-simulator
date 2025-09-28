class_name Ball extends Node2D

signal run_finished(_destination_position: Vector2)

@onready var state_machine: BallStateMachine = $BallStateMachine
@onready var animation_player: AnimationPlayer = $AnimationPlayer

var target_position: Vector2 = Vector2.ZERO

func run(_target_position: Vector2) -> void:
	target_position = _target_position
	state_machine.change_to('run')

func _ready() -> void:
	state_machine.initialize(self)
	state_machine.states['run'].run_finished.connect(_run_finished)

func update_animation( animation: String) -> void:
	animation_player.play(animation)

func _run_finished(_destination_position: Vector2) -> void:
	state_machine.change_to('idle')
	run_finished.emit(_destination_position)
