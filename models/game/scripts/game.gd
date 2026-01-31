class_name Game extends Node2D

signal action_finished(outcome: GameOutcome)

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

var logger: Logger = Logger.initialize("game")

var current_action: ActionName = ActionName.IDLE

var ball: Ball
var banner: Banner
var home_player: Player
var away_player: Player
var score: Score

@onready var state_machine: GameStateMachine = $GameStateMachine
@onready var point: Point = $Point


func initialize(_banner: Banner, _ball: Ball, _home_player: Player, _away_player: Player, _score: Score) -> void:
	banner = _banner
	ball = _ball
	home_player = _home_player
	away_player = _away_player

	score = _score

	state_machine.initialize(self)

	state_machine.states[Game.StateName.START].state_finished.connect(_on_start_state_finished)
	state_machine.states[Game.StateName.PLAY].state_finished.connect(_on_play_state_finished)
	state_machine.states[Game.StateName.END].state_finished.connect(_on_end_state_finished)

	point.initialize(_banner, _ball, _home_player, _away_player, _score)


func start_game_action() -> void:
	current_action = Game.ActionName.START
	state_machine.change_to(Game.StateName.START)


func _on_start_state_finished(_state_outcome: GameOutcome) -> void:
	current_action = Game.ActionName.PLAY
	state_machine.change_to(Game.StateName.PLAY)


func _on_play_state_finished(_state_outcome: GameOutcome) -> void:
	current_action = Game.ActionName.END
	state_machine.change_to(Game.StateName.END)

func _on_end_state_finished(state_outcome: GameOutcome) -> void:
	current_action = Game.ActionName.IDLE
	state_machine.change_to(Game.StateName.IDLE)

	print("game.gd state_outcome.game_winner: ", state_outcome.game_winner)
	print("game.gd state_outcome.action_name: ", state_outcome.action_name)
	print("game.gd state_outcome.state_name: ", state_outcome.state_name)

	var action_outcome: GameOutcome = GameOutcome.action_end_outcome(state_outcome.action_name, state_outcome.game_winner)
	action_finished.emit(action_outcome)
