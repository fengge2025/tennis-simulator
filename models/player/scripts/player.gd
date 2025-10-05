class_name Player extends Node2D

signal hit_finished(desire_ball_position: Vector2)
signal start_run_finished()

@onready var state_machine: PlayerStateMachine = $PlayerStateMachine
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var sprite_2d: Sprite2D = $Sprite2D

@export_enum("home", "away") var home_or_away: String = "home"
@export var color: Color = Color.WHITE

enum ACTION {IDLE, START, PLAY, END}

var current_action: ACTION = ACTION.IDLE

var config_territory: Dictionary = {
	"hit_x_min": 100,
	"hit_x_max": 300,
	"hit_y_min": 100,
	"hit_y_max": 300
}

var target_position: Vector2 = Vector2.ZERO

func hit_and_run(_target_position: Vector2) -> void:
	current_action = ACTION.PLAY
	_run_handler(_target_position)

func start_point(_target_position: Vector2) -> void:
	current_action = ACTION.START
	_run_handler(_target_position)

func _ready() -> void:
	sprite_2d.modulate = color
	
	state_machine.initialize(self)
	state_machine.states['run'].run_finished.connect(_run_finished)
	state_machine.states['hit'].hit_finished.connect(_hit_finished)

func _process(_delta: float) -> void:
	pass

func update_animation( animation: String) -> void:
	animation_player.play(animation)

func hit_desire_position() -> Vector2:
	var rand_vec = Vector2(
		randf_range(config_territory["hit_x_min"], config_territory["hit_x_max"]),
		randf_range(config_territory["hit_y_min"], config_territory["hit_y_max"])
	)	
	return rand_vec

func _run_handler(_target_position: Vector2) -> void:
	target_position = _target_position
	state_machine.change_to('run')

func _run_finished(action: ACTION) -> void:
	match action:
		ACTION.IDLE:
			pass
		ACTION.START:
			state_machine.change_to('idle')
			start_run_finished.emit()
		ACTION.PLAY:
			state_machine.change_to('hit')
		ACTION.END:
			pass
		_:
			pass


func _hit_finished(hit_result: String, desire_ball_position: Vector2) -> void:
	state_machine.change_to('idle')
	hit_finished.emit(hit_result, desire_ball_position)
