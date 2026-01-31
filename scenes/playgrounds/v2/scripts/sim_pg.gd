extends Node

@onready var manager: Manager = $Manager

func _ready() -> void:
	#player.action_finished.connect(_on_player_action_finished)

	# var v: Vector2 = Vector2(100, 100)
	#player.prepare_action(v)
	manager.initialize()
	
	manager.start_point_action()
