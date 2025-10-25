class_name Point extends Node2D

signal action_finished(state_outcome: PointOutcome)

enum ActionName { IDLE, START_POINT, PLAY, END }
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

	state_machine.states[Point.StateName.PREPARE].state_finished.connect(_on_prepare_state_finished)
	state_machine.states[Point.StateName.PLAY].state_finished.connect(_on_play_state_finished)
	state_machine.states[Point.StateName.END].state_finished.connect(_on_end_state_finished)


func start_point_action() -> void:
	current_action = ActionName.START_POINT
	state_machine.change_to(Point.StateName.PREPARE)


static func get_score_player_home_or_away(miss_home_or_away: Player.HomeOrAway) -> Player.HomeOrAway:
	match miss_home_or_away:
		Player.HomeOrAway.HOME:
			return Player.HomeOrAway.AWAY
		Player.HomeOrAway.AWAY:
			return Player.HomeOrAway.HOME
		_:
			push_error("fail to get score player home or away")
			return Player.HomeOrAway.HOME


func _ready() -> void:
	pass


func _on_prepare_state_finished(_state_outcome: PointOutcome) -> void:
	current_action = ActionName.PLAY
	state_machine.change_to(Point.StateName.PLAY)


func _on_play_state_finished(_state_outcome: PointOutcome) -> void:
	print("_on_play_state_finished: ", score_home_or_away, " score")
	current_action = ActionName.END
	state_machine.change_to(Point.StateName.END)

func _on_end_state_finished(state_outcome: PointOutcome) -> void:
	current_action = ActionName.IDLE
	state_machine.change_to(Point.StateName.IDLE)
	action_finished.emit(state_outcome)
