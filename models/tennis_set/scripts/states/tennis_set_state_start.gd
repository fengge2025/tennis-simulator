class_name TennisSetStateStart extends TennisSetState

func _ready() -> void:
	state_name = TennisSet.StateName.START


func enter() -> void:
	tennis_set.logger.log("tennis set enter start")
	state_processing = true

func reenter() -> void:
	tennis_set.logger.log("tennis set reenter start")


func exit() -> void:
	state_processing = false


func process(delta: float) -> State:
	return pass_process(delta)
