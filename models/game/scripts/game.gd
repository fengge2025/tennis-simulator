class_name Game extends Node2D

signal update_score(score: ScoreBoard.Score)

var logger: Logger = Logger.initialize("game")

@onready var state_machine: GameStateMachine = $GameStateMachine
@onready var point: Point = $Point

enum ACTION {
	IDLE,
	START,
	PLAY,
	END,
}

var current_action: ACTION = ACTION.IDLE

var ball: Ball
var banner: Banner
var home_player: Player
var away_player: Player

var score: ScoreBoard.Score

func initialize(_banner: Banner, _ball: Ball, _home_player: Player, _away_player: Player) -> void:
	banner = _banner
	ball = _ball
	home_player = _home_player
	away_player = _away_player

	score = ScoreBoard.Score.new()
	update_score.emit(score)

	state_machine.initialize(self)

	state_machine.states['start'].state_finished.connect(_on_start_finished)
	state_machine.states['play'].state_finished.connect(_on_play_finished)
	state_machine.states['play'].update_score.connect(_on_play_update_score)
	state_machine.states['end'].state_finished.connect(_on_end_finished)

	point.initialize(_banner, _ball, _home_player, _away_player)

func start_game() -> void:
	state_machine.change_to("start")

func _on_start_finished(_state_outcome: GameStateOutcome) -> void:
	state_machine.change_to("play")

func _on_play_finished(_state_outcome: GameStateOutcome) -> void:
	pass

func _on_play_update_score() -> void:
	update_score.emit(score)	

func _on_end_finished(_state_outcome: GameStateOutcome) -> void:
	pass
