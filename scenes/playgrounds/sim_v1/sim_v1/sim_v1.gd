extends Node

@onready var sim_manager: SimManager = $SimManager


func _ready() -> void:
	sim_manager.initialize()
	sim_manager.start_sim()
