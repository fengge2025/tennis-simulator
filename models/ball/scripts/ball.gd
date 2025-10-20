class_name Ball extends Node2D

signal action_finished(action_outcome: BallOutcome)

enum ActionName { IDLE, PREPARE, RUN }
enum StateName { IDLE, RUN }

var logger: Logger = Logger.initialize("ball")

var current_action: ActionName = ActionName.IDLE
var target_position: Vector2 = Vector2.ZERO

@onready var state_machine: BallStateMachine = $BallStateMachine
@onready var animation_player: AnimationPlayer = $AnimationPlayer


func prepare_action(_target_position: Vector2) -> void:
	current_action = ActionName.PREPARE
	_run_handler(_target_position)


func run_action(_target_position: Vector2) -> void:
	current_action = ActionName.RUN
	_run_handler(_target_position)


func idle_action() -> void:
	current_action = ActionName.IDLE
	state_machine.change_to(StateName.IDLE)


func update_animation(animation: String) -> void:
	animation_player.play(animation)


func _ready() -> void:
	state_machine.initialize(self)
	state_machine.states[StateName.RUN].state_finished.connect(_on_run_state_finished)


func _run_handler(_target_position: Vector2) -> void:
	target_position = _target_position
	state_machine.change_to(StateName.RUN)


func _on_run_state_finished(state_outcome: BallOutcome) -> void:
	match state_outcome.state_name:
		StateName.IDLE:
			pass
		StateName.RUN:
			state_machine.change_to(StateName.IDLE)
			match state_outcome.action_name:
				ActionName.PREPARE:
					var action_outcome: BallOutcome = BallOutcome.action_run_outcome(
						state_outcome.action_name
					)
					action_finished.emit(action_outcome)
				ActionName.RUN:
					var action_outcome: BallOutcome = BallOutcome.action_run_outcome(
						state_outcome.action_name
					)
					action_finished.emit(action_outcome)
				_:
					pass
		_:
			pass
