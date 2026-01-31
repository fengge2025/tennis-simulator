class_name TennisSetStateEnd extends TennisSetState


func _ready() -> void:
	state_name = TennisSet.StateName.END


func enter() -> void:
	tennis_set.logger.log("tennis set enter end")
	state_processing = true

func reenter() -> void:
	tennis_set.logger.log("tennis set reenter end")

func exit() -> void:
	state_processing = false


func process(delta: float) -> State:
	return pass_process(delta)
