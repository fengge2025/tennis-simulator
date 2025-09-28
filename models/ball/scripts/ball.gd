class_name Ball extends Node2D

signal run_finished(destination_position: Vector2)
signal start_run_finished()

@onready var state_machine: BallStateMachine = $BallStateMachine
@onready var animation_player: AnimationPlayer = $AnimationPlayer

enum ACTION {IDLE, START, RUN}

var target_position: Vector2 = Vector2.ZERO
var current_action: ACTION = ACTION.IDLE

func start_point(_target_position: Vector2) -> void:
	current_action = ACTION.START
	_run_handler(_target_position)

func run(_target_position: Vector2) -> void:
	current_action = ACTION.RUN
	_run_handler(_target_position)

func _ready() -> void:
	state_machine.initialize(self)
	state_machine.states['run'].run_finished.connect(_run_finished)

func update_animation(animation: String) -> void:
	animation_player.play(animation)

func _run_handler(_target_position: Vector2) -> void:
	target_position = _target_position
	state_machine.change_to('run')

func _run_finished(action: ACTION, destination_position: Vector2) -> void:
	match action:
		ACTION.IDLE:
			pass
		ACTION.START:
			state_machine.change_to('idle')
			start_run_finished.emit()
		ACTION.RUN:
			state_machine.change_to('idle')
			run_finished.emit(destination_position)
		_:
			pass


func _start_run_finished() -> void:
	start_run_finished.emit()
