extends Node

@onready var player: Player = $Player

func _ready() -> void:
	#player.target_position = Vector2(100, 100)
	#player.player_state_machine.change_to('run')
	
	player.player_state_machine.change_to('hit')
