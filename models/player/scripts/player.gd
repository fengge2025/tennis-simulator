class_name Player extends Node2D

signal state_finished(state_outcome: PlayerStateOutcome)

enum Action { IDLE, PREPARE, HIT_AND_RUN, END }

@export_enum("home", "away") var home_or_away: String = "home"
@export var color: Color = Color.WHITE

var logger: Logger = Logger.initialize("player")

var current_action: Action = Action.IDLE

var match_configs: MatchConfig

var target_position: Vector2 = Vector2.ZERO

var player_stat: PlayerStat
var player_hit: PlayerHit

@onready var state_machine: PlayerStateMachine = $PlayerStateMachine
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var label: Label = $Label


func hit_and_run(_target_position: Vector2) -> void:
	current_action = Action.HIT_AND_RUN
	target_position = _target_position
	state_machine.change_to("run")


func prepare(_target_position: Vector2) -> void:
	current_action = Action.PREPARE
	target_position = _target_position
	state_machine.change_to("run")


func _ready() -> void:
	label.text = home_or_away
	sprite_2d.modulate = color

	match_configs = LoadConfigs.match_configs.get(home_or_away)
	if match_configs.loaded == false:
		logger.error("Match configs not loaded for player %s" % home_or_away)

	player_stat = PlayerStat.new(12, 20, 20)
	player_hit = PlayerHit.new(match_configs, player_stat)

	state_machine.initialize(self)
	state_machine.states["run"].state_finished.connect(_on_state_finished)

	animation_player.animation_finished.connect(_on_animation_finished)


func update_animation(animation: String) -> void:
	animation_player.play(animation)


func _on_state_finished(state_outcome: PlayerStateOutcome) -> void:
	match state_outcome.action:
		Action.IDLE:
			pass
		Action.PREPARE:
			state_machine.change_to("idle")
			state_finished.emit(state_outcome)
		Action.HIT_AND_RUN:
			state_machine.change_to("hit")
		Action.END:
			pass
		_:
			pass


func _on_animation_finished(animation_name: String) -> void:
	match animation_name:
		"hit":
			var state_outcome: PlayerStateOutcome = PlayerStateOutcome.hit_outcome(
				current_action,
				home_or_away,
				player_hit.get_hit_result(),
				player_hit.get_hit_desire_position()
			)
			state_finished.emit(state_outcome)
		_:
			pass
