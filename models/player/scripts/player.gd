class_name Player extends Node2D

signal action_finished(action_outcome: PlayerOutcome.PlayerActionOutcome)

enum ActionName { IDLE, PREPARE, HIT, RUN, END }
enum StateName { IDLE, RUN, HIT, WAIT }
enum HomeOrAway { HOME, AWAY }

@export var color: Color = Color.WHITE
@export var home_or_away: HomeOrAway = HomeOrAway.HOME

var logger: Logger = Logger.initialize("player")

var current_action: ActionName = ActionName.IDLE

var match_configs: MatchConfig

var target_position: Vector2 = Vector2.ZERO

var player_stat: PlayerStat
var player_hit: PlayerHit

# this is to check if a player has run to target position
var on_target_position: bool = false

@onready var state_machine: PlayerStateMachine = $PlayerStateMachine
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var label: Label = $Label

func run_action(_target_position: Vector2) -> void:
	current_action = ActionName.RUN
	on_target_position = false
	_run_handler(_target_position)


func hit_action() -> void:
	current_action = ActionName.HIT
	state_machine.change_to(StateName.HIT)


func prepare_action(_target_position: Vector2) -> void:
	current_action = ActionName.PREPARE
	_run_handler(_target_position)


func get_prepare_target_position() -> Vector2:
	return Vector2(
		match_configs.prepare_x,
		match_configs.prepare_y
	)


func get_hit_target_position() -> Vector2:
	var rand_vec: Vector2 = Vector2(
		randf_range(match_configs["hit_x_min"], match_configs["hit_x_max"]),
		randf_range(match_configs["hit_y_min"], match_configs["hit_y_max"])
	)
	return rand_vec


func update_animation(animation: String) -> void:
	animation_player.play(animation)


func _ready() -> void:
	label.text = str(home_or_away)
	sprite_2d.modulate = color

	match_configs = LoadConfigs.match_configs.get(home_or_away)
	if match_configs.loaded == false:
		logger.error("Match configs not loaded for player %s" % home_or_away)

	player_stat = PlayerStat.new(6, 20, 20)
	player_hit = PlayerHit.new(match_configs, player_stat)

	state_machine.initialize(self)

	for state: PlayerState in state_machine.states.values():
		state.state_finished.connect(_on_state_finished)


func _run_handler(_target_position: Vector2) -> void:
	target_position = _target_position
	state_machine.change_to(StateName.RUN)


func _on_state_finished(state_outcome: PlayerOutcome.PlayerStateOutcome) -> void:
	match state_outcome.state_name:
		StateName.RUN:
			match state_outcome.action_name:
				ActionName.PREPARE:
					current_action = ActionName.IDLE
					state_machine.change_to(StateName.IDLE)
					var action_outcome: PlayerOutcome.PlayerActionPrepareOutcome = (
						PlayerOutcome.PlayerActionPrepareOutcome.new_prepare_outcome(home_or_away)
					)
					action_finished.emit(action_outcome)
				ActionName.RUN:
					state_machine.change_to(StateName.WAIT)
				_:
					logger.error("Unexpected action name in RUN state finished")
		StateName.HIT:
			match state_outcome.action_name:
				ActionName.HIT:
					current_action = ActionName.IDLE
					state_machine.change_to(StateName.IDLE)
					var action_outcome: PlayerOutcome.PlayerActionHitOutcome = (
						PlayerOutcome
						. PlayerActionHitOutcome
						. new_hit_outcome(
							home_or_away,
							player_hit.get_hit_result(),
							player_hit.get_hit_desire_position()
						)
					)
					action_finished.emit(action_outcome)
				_:
					logger.error("Unexpected action name in HIT state finished")
		StateName.WAIT:
			pass
		StateName.IDLE:
			pass
		_:
			logger.error("Unexpected state name in player state finished")
