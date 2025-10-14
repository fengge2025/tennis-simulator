class_name GameStateEnd extends GameState

func _ready() -> void:
	state_name = "end"

func enter() -> void:
	game.logger.log("game enter end")
	state_processing = true

func exit() -> void:
	state_processing = false

func process(delta: float) -> State:
	return wait_process(delta)
