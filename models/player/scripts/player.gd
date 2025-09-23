class_name Player extends Node2D

@export_enum("home", "away") var home_or_away: String = "home"

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var player_state_machine: PlayerStateMachine = $PlayerStateMachine

#var config_territory: Dictionary = {}
var target_position: Vector2 = Vector2.ZERO

func _ready() -> void:
	player_state_machine.initialize(self)
	#config_territory = Configs.configs[home_or_away]

func _process(_delta: float) -> void:
	pass

func update_animation( animation: String) -> void:
	animation_player.play(animation)

func hit_desire_position() -> Vector2:
	#var rand_vec = Vector2(
		#randf_range(config_territory["hit_x_min"], config_territory["hit_x_max"]),
		#randf_range(config_territory["hit_y_min"], config_territory["hit_y_max"])
	#)
	
	var rand_vec = Vector2(100, 100)
	
	return rand_vec
