class_name Point extends Node2D

var logger: Logger = Logger.initialize("point")

signal state_finished(state_outcome: PointStateOutcome)

@onready var state_machine: PointStateMachine = $PointStateMachine

enum ACTION {
	IDLE,
	PREPARE,
	HIT,
	END,
}

enum POINT_RESULT {
	HOME_PLAYER_SCORED,
	AWAY_PLAYER_SCORED,
}

var current_action: ACTION = ACTION.IDLE

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
		else:
			return away_player
var receive_player: Player:
	get:
		if receive_turn == 0:
			return away_player
		else:
			return home_player


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
	current_action = ACTION.PREPARE
	state_machine.change_to("prepare")


func _ready() -> void:
	pass


func _on_prepare_finished(_state_outcome: PointStateOutcome) -> void:
	current_action = ACTION.HIT
	state_machine.change_to("hit")


func _on_hit_finished(state_outcome: PointStateOutcome) -> void:
	score_home_or_away = state_outcome.score_home_or_away
	current_action = ACTION.END
	state_machine.change_to("end")


func _on_end_finished(state_outcome: PointStateOutcome) -> void:
	state_machine.change_to("idle")
	state_finished.emit(state_outcome)
