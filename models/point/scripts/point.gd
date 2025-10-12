class_name Point extends Node2D

@onready var state_machine: PointStateMachine = $PointStateMachine

enum ACTION {
	PREPARE,
	HIT,
	END,
}

var ball: Ball
var banner: Banner
var hit_player: Player
var receive_player: Player

func initialize(_banner: Banner, _ball: Ball, _player_a: Player, _player_b: Player) -> void:
	banner = _banner
	ball = _ball
	hit_player = _player_a
	receive_player = _player_b
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
