class_name Ball extends Node2D

var logger: Logger = Logger.initialize("ball")

signal state_finished(state_outcome: BallStateOutcome)

@onready var state_machine: BallStateMachine = $BallStateMachine
@onready var animation_player: AnimationPlayer = $AnimationPlayer

enum ACTION {IDLE, PREPARE, RUN}

var target_position: Vector2 = Vector2.ZERO
var current_action: ACTION = ACTION.IDLE

func prepare(_target_position: Vector2) -> void:
	current_action = ACTION.PREPARE
	_run_handler(_target_position)

func run(_target_position: Vector2) -> void:
	current_action = ACTION.RUN
	_run_handler(_target_position)

func _ready() -> void:
	state_machine.initialize(self)
	state_machine.states['run'].state_finished.connect(_on_state_finished)

func update_animation(animation: String) -> void:
	animation_player.play(animation)

func _run_handler(_target_position: Vector2) -> void:
	target_position = _target_position
	state_machine.change_to('run')

func _on_state_finished(state_outcome: BallStateOutcome) -> void:
	match state_outcome.action:
		ACTION.IDLE:
			pass
		ACTION.PREPARE:
			state_machine.change_to('idle')
			state_finished.emit(state_outcome)
		ACTION.RUN:
			state_machine.change_to('idle')
			state_finished.emit(state_outcome)
		_:
			pass
