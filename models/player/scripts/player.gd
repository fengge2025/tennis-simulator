class_name Player extends Node2D

signal action_finished(action_outcome: PlayerOutcome)

enum ActionName { IDLE, PREPARE, HIT_AND_RUN, END }
enum StateName { IDLE, RUN, HIT }

@export_enum("home", "away") var home_or_away: String = "home"
@export var color: Color = Color.WHITE

var logger: Logger = Logger.initialize("player")

var current_action: ActionName = ActionName.IDLE

var match_configs: MatchConfig

var target_position: Vector2 = Vector2.ZERO

var player_stat: PlayerStat
var player_hit: PlayerHit

@onready var state_machine: PlayerStateMachine = $PlayerStateMachine
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var label: Label = $Label


func hit_and_run_action(_target_position: Vector2) -> void:
	current_action = ActionName.HIT_AND_RUN
	_run_handler(_target_position)


func prepare_action(_target_position: Vector2) -> void:
	current_action = ActionName.PREPARE
	_run_handler(_target_position)


func update_animation(animation: String) -> void:
	animation_player.play(animation)


func _ready() -> void:
	label.text = home_or_away
	sprite_2d.modulate = color

	match_configs = LoadConfigs.match_configs.get(home_or_away)
	if match_configs.loaded == false:
		logger.error("Match configs not loaded for player %s" % home_or_away)

	player_stat = PlayerStat.new(12, 20, 20)
	player_hit = PlayerHit.new(match_configs, player_stat)

	state_machine.initialize(self)
	state_machine.states[StateName.RUN].state_finished.connect(_on_run_state_finished)

	animation_player.animation_finished.connect(_on_animation_finished)


func _run_handler(_target_position: Vector2) -> void:
	target_position = _target_position
	state_machine.change_to(StateName.RUN)


func _on_run_state_finished(state_outcome: PlayerOutcome) -> void:
	match state_outcome.state_name:
		StateName.IDLE:
			pass
		StateName.RUN:
			match state_outcome.action_name:
				ActionName.PREPARE:
					state_machine.change_to(StateName.IDLE)
					var action_outcome: PlayerOutcome = PlayerOutcome.action_run_outcome(
						state_outcome.action_name
					)
					action_finished.emit(action_outcome)
				ActionName.HIT_AND_RUN:
					state_machine.change_to(StateName.HIT)
				_:
					pass
		_:
			pass


func _on_animation_finished(animation_name: String) -> void:
	match animation_name:
		"hit":
			var action_outcome: PlayerOutcome = PlayerOutcome.action_hit_and_run_outcome(
				current_action
			)
			action_finished.emit(action_outcome)
		_:
			pass
