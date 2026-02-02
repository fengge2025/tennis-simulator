class_name Point extends Node2D

signal action_finished(state_outcome: PointOutcome.PointActionOutcome)

enum ActionName { IDLE, PREPARE, PLAY, END }
enum StateName { IDLE, PREPARE, PLAY, END }

var logger: Logger = Logger.initialize("point")

var current_action: ActionName = ActionName.IDLE

var ball: Ball
var banner: Banner
var home_player: Player
var away_player: Player

var receive_turn: int = 0
var score_home_or_away: Player.HomeOrAway

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

	for state: PointState in state_machine.states.values():
		state.state_finished.connect(_on_state_finished)


func start_point_action() -> void:
	current_action = ActionName.PREPARE
	state_machine.change_to(Point.StateName.PREPARE)


static func get_score_player_home_or_away(
	miss_home_or_away: Player.HomeOrAway
) -> Player.HomeOrAway:
	match miss_home_or_away:
		Player.HomeOrAway.HOME:
			return Player.HomeOrAway.AWAY
		Player.HomeOrAway.AWAY:
			return Player.HomeOrAway.HOME
		_:
			push_error("fail to get score player home or away")
			return Player.HomeOrAway.HOME


func _on_state_finished(state_outcome: PointOutcome.PointStateOutcome) -> void:
	match state_outcome.state_name:
		Point.StateName.PREPARE:
			current_action = ActionName.PLAY
			state_machine.change_to(Point.StateName.PLAY)
		Point.StateName.PLAY:
			current_action = ActionName.END
			state_machine.change_to(Point.StateName.END)
		Point.StateName.END:
			current_action = ActionName.IDLE
			state_machine.change_to(Point.StateName.IDLE)

			print("point score:", state_outcome.score_home_or_away)
			var action_outcome: PointOutcome.PointActionEndOutcome = (
				PointOutcome.PointActionEndOutcome.new_end_outcome(state_outcome.score_home_or_away)
			)
			print("_on_end_state_finished", state_outcome.action_name)

			action_finished.emit(action_outcome)
		_:
			logger.error("Unexpected state name in point state finished")
