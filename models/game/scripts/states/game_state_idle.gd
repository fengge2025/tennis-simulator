class_name GameStateIdle extends GameState


func _ready() -> void:
	state_name = Game.StateName.IDLE


func enter() -> void:
	game.logger.log("game enter idle")
	state_processing = true

func reenter() -> void:
	game.logger.log("game reenter idle")

func exit() -> void:
	state_processing = false


func process(delta: float) -> State:
	return wait_process(delta)
