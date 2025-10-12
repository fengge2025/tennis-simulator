class_name Player extends Node2D

signal state_finished(state_outcome: PlayerStateOutcome)

@onready var state_machine: PlayerStateMachine = $PlayerStateMachine
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var sprite_2d: Sprite2D = $Sprite2D

@export_enum("home", "away") var home_or_away: String = "home"
@export var color: Color = Color.WHITE

enum ACTION {IDLE, PREPARE, HIT_AND_RUN, END}
enum HIT_RESULT {HIT, MISS}

var current_action: ACTION = ACTION.IDLE

var config_territory: Dictionary = {
	"hit_x_min": 100,
	"hit_x_max": 300,
	"hit_y_min": 100,
	"hit_y_max": 300
}

var target_position: Vector2 = Vector2.ZERO

func hit_and_run(_target_position: Vector2) -> void:
	current_action = ACTION.HIT_AND_RUN
	target_position = _target_position
	state_machine.change_to('run')

func prepare(_target_position: Vector2) -> void:
	current_action = ACTION.PREPARE
	target_position = _target_position
	state_machine.change_to('run')

func _ready() -> void:
	sprite_2d.modulate = color
	
	state_machine.initialize(self)
	state_machine.states['run'].state_finished.connect(_on_state_finished)

	animation_player.animation_finished.connect(_on_animation_finished)

func _process(_delta: float) -> void:
	pass

func update_animation( animation: String) -> void:
	animation_player.play(animation)

func _hit_desire_position() -> Vector2:
	var rand_vec = Vector2(
		randf_range(config_territory["hit_x_min"], config_territory["hit_x_max"]),
		randf_range(config_territory["hit_y_min"], config_territory["hit_y_max"])
	)	
	return rand_vec

func _on_state_finished(state_outcome: PlayerStateOutcome) -> void:
	match state_outcome.action:
		ACTION.IDLE:
			pass
		ACTION.PREPARE:
			state_machine.change_to('idle')
			state_finished.emit(state_outcome)
		ACTION.HIT_AND_RUN:
			print(home_or_away)
			state_machine.change_to('hit')
		ACTION.END:
			pass
		_:
			pass

func _get_random_int() -> int:
	randomize() # ensures different result each time you run the game
	return randi_range(0, 100)
	
func _get_hit_result() -> Player.HIT_RESULT:
	var a = _get_random_int()
	print(a)
	if a > 50:
		return Player.HIT_RESULT.HIT
	else:
		return Player.HIT_RESULT.MISS


func _on_animation_finished(animation_name: String) -> void:
	match animation_name:
		"hit":
			var hit_desire_position1 = _hit_desire_position()
			var hit_result1 = _get_hit_result()
			print("_on_animation_finished")
			print(hit_desire_position1)
			print(hit_result1)

			var state_outcome = PlayerStateOutcome.hit_outcome(current_action, hit_result1, hit_desire_position1)
			state_finished.emit(state_outcome)
		_:
			pass