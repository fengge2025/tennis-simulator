class_name GameStateStart extends GameState

func _ready() -> void:
	state_name = "start"

func enter() -> void:
	game.logger.log("game enter start")
	state_processing = true

func exit() -> void:
	state_processing = false

func process(delta: float) -> State:
	return pass_process(delta)