class_name TennisSet extends Node2D

enum ActionName {
	IDLE,
	START,
	PLAY,
	END,
}

enum StateName {
	END,
	IDLE,
	PLAY,
	START
}

var logger: Logger = Logger.initialize("tennis_set")

var current_action: ActionName = ActionName.IDLE

var ball: Ball
var banner: Banner
var home_player: Player
var away_player: Player

var score: Score

@onready var state_machine: TennisSetStateMachine = $TennisSetStateMachine
@onready var game: Game = $Game


func _ready() -> void:
	pass


func initialize(_banner: Banner, _ball: Ball, _home_player: Player, _away_player: Player, _score: Score) -> void:
	banner = _banner
	ball = _ball
	home_player = _home_player
	away_player = _away_player

	score = _score

	state_machine.initialize(self)

	state_machine.states[StateName.START].state_finished.connect(_on_start_state_finished)
	state_machine.states[StateName.PLAY].state_finished.connect(_on_play_state_finished)
	state_machine.states[StateName.END].state_finished.connect(_on_end_state_finished)

	game.initialize(_banner, _ball, _home_player, _away_player, _score)


func start_set_action() -> void:
	current_action = TennisSet.ActionName.START
	state_machine.change_to(TennisSet.StateName.START)


func _on_start_state_finished(_state_outcome: TennisSetOutcome) -> void:
	current_action = TennisSet.ActionName.PLAY
	state_machine.change_to(TennisSet.StateName.PLAY)


func _on_play_state_finished(_state_outcome: TennisSetOutcome) -> void:
	current_action = TennisSet.ActionName.END
	state_machine.change_to(TennisSet.StateName.END)


func _on_end_state_finished(_state_outcome: TennisSetOutcome) -> void:
	current_action = TennisSet.ActionName.IDLE
	state_machine.change_to(TennisSet.StateName.IDLE)
