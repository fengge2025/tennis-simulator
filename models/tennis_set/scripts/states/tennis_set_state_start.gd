class_name TennisSetStateStart extends TennisSetState


func _ready() -> void:
	state_name = "start"


func enter() -> void:
	tennis_set.logger.log("tennis set enter start")
	state_processing = true


func exit() -> void:
	state_processing = false


func process(delta: float) -> State:
	return pass_process(delta)
