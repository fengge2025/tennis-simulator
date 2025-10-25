class_name GameStateEnd extends GameState


func _ready() -> void:
	state_name = Game.StateName.END


func enter() -> void:
	game.logger.log("game enter end")
	state_processing = true

func reenter() -> void:
	game.logger.log("game reenter end")

func exit() -> void:
	state_processing = false


func process(delta: float) -> State:
	return wait_process(delta)
