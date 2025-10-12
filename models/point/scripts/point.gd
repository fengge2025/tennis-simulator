class_name Point extends Node2D

var logger: Logger = Logger.initialize("point")

@onready var state_machine: PointStateMachine = $PointStateMachine

enum ACTION {
	PREPARE,
	HIT,
	END,
}

var ball: Ball
var banner: Banner
var home_player: Player
var away_player: Player
var receive_turn: int = 0

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

	state_machine.states['prepare'].state_finished.connect(_on_prepare_finished)
	state_machine.states['hit'].state_finished.connect(_on_hit_finished)
	state_machine.states['end'].state_finished.connect(_on_end_finished)

func start_point() -> void:
	state_machine.change_to("prepare")

func _ready() -> void:
	pass

func _on_prepare_finished() -> void:
	state_machine.change_to("hit")

func _on_hit_finished() -> void:
	state_machine.change_to("end")

func _on_end_finished() -> void:
	state_machine.change_to("prepare")
