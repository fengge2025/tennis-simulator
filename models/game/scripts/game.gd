class_name Game extends Node2D

signal action_update_score(outcome: GameOutcome)

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

var score: ScoreBoard.Score

@onready var state_machine: GameStateMachine = $GameStateMachine
@onready var point: Point = $Point


func initialize(_banner: Banner, _ball: Ball, _home_player: Player, _away_player: Player) -> void:
	banner = _banner
	ball = _ball
	home_player = _home_player
	away_player = _away_player

	score = ScoreBoard.Score.new()
	var outcome: GameOutcome = GameOutcome.action_play_update_score_outcome(current_action, score)
	action_update_score.emit(outcome)

	state_machine.initialize(self)

	state_machine.states[Game.StateName.START].state_finished.connect(_on_start_state_finished)
	# state_machine.states[Game.StateName.PLAY].state_finished.connect(_on_play_finished)
	state_machine.states[Game.StateName.PLAY].action_update_score.connect(_on_play_action_update_score)
	#state_machine.states[Game.StateName.END].state_finished.connect(_on_end_finished)

	point.initialize(_banner, _ball, _home_player, _away_player)


func start_game_action() -> void:
	current_action = Game.ActionName.START
	state_machine.change_to(Game.StateName.START)


func _on_start_state_finished(_state_outcome: GameOutcome) -> void:
	current_action = Game.ActionName.PLAY
	state_machine.change_to(Game.StateName.PLAY)


func _on_play_state_finished(_state_outcome: GameOutcome) -> void:
	pass


func _on_play_action_update_score(state_outcome: GameOutcome) -> void:
	action_update_score.emit(state_outcome)


func _on_end_finished(_state_outcome: GameOutcome) -> void:
	pass
