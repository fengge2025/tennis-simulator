class_name Point extends Node2D

signal state_finished(state_outcome: PointStateOutcome)

enum Action {
	IDLE,
	PREPARE,
	HIT,
	END,
}

enum PointResult {
	HOME_PLAYER_SCORED,
	AWAY_PLAYER_SCORED,
}

var logger: Logger = Logger.initialize("point")

var current_action: Action = Action.IDLE

var ball: Ball
var banner: Banner
var home_player: Player
var away_player: Player
var receive_turn: int = 0
var score_home_or_away: String = "home"

var hit_player: Player:
	get:
		if receive_turn == 0:
			return home_player

		return away_player
var receive_player: Player:
	get:
		if receive_turn == 0:
			return away_player

		return home_player

@onready var state_machine: PointStateMachine = $PointStateMachine


func initialize(_banner: Banner, _ball: Ball, _home_player: Player, _away_player: Player) -> void:
	banner = _banner
	ball = _ball
	home_player = _home_player
	away_player = _away_player
	state_machine.initialize(self)

	state_machine.states["prepare"].state_finished.connect(_on_prepare_finished)
	state_machine.states["hit"].state_finished.connect(_on_hit_finished)
	state_machine.states["end"].state_finished.connect(_on_end_finished)


func start_point() -> void:
	current_action = Action.PREPARE
	state_machine.change_to(1)


func _ready() -> void:
	pass


func _on_prepare_finished(_state_outcome: PointStateOutcome) -> void:
	current_action = Action.HIT
	state_machine.change_to(1)


func _on_hit_finished(state_outcome: PointStateOutcome) -> void:
	score_home_or_away = state_outcome.score_home_or_away
	current_action = Action.END
	state_machine.change_to(1)


func _on_end_finished(state_outcome: PointStateOutcome) -> void:
	state_machine.change_to(1)
	state_finished.emit(state_outcome)
