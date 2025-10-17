class_name TennisSet extends Node2D

enum Action {
	IDLE,
	START,
	PLAY,
	END,
}

var logger: Logger = Logger.initialize("tennis_set")

var current_action: Action = Action.IDLE

var ball: Ball
var banner: Banner
var home_player: Player
var away_player: Player

var score: ScoreBoard.Score

@onready var state_machine: TennisSetStateMachine = $TennisSetStateMachine
@onready var game: Game = $Game


func _ready() -> void:
	pass


func initialize(_banner: Banner, _ball: Ball, _home_player: Player, _away_player: Player) -> void:
	banner = _banner
	ball = _ball
	home_player = _home_player
	away_player = _away_player

	score = ScoreBoard.Score.new()

	state_machine.initialize(self)

	state_machine.states["start"].state_finished.connect(_on_start_finished)
	state_machine.states["play"].state_finished.connect(_on_play_finished)
	state_machine.states["end"].state_finished.connect(_on_end_finished)

	game.initialize(_banner, _ball, _home_player, _away_player)


func start_set() -> void:
	state_machine.change_to("start")


func _on_start_finished(_state_outcome: TennisSetStateOutcome) -> void:
	state_machine.change_to("play")


func _on_play_finished(_state_outcome: TennisSetStateOutcome) -> void:
	state_machine.change_to("end")


func _on_end_finished(_state_outcome: TennisSetStateOutcome) -> void:
	state_machine.change_to("start")
