class_name GameStateStart extends GameState

func _ready() -> void:
	state_name = Game.StateName.START


func enter() -> void:
	game.logger.log("game enter start")
	state_processing = true


func reenter() -> void:
	game.logger.log("game reenter start")


func exit() -> void:
	state_processing = false


func process(delta: float) -> State:
	return pass_process(delta)
