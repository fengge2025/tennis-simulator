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


func process(_delta: float) -> State:
	if state_processing:
		state_processing = false
	else:
		var state_outcome: GameOutcome = GameOutcome.state_end_outcome(
			game.current_action, state_name
		)
		state_finished.emit(state_outcome)
	return null
