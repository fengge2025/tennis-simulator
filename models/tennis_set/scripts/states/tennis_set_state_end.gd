class_name TennisSetStateEnd extends TennisSetState


func _ready() -> void:
	state_name = "end"


func enter() -> void:
	tennis_set.logger.log("tennis set enter end")
	state_processing = true


func exit() -> void:
	state_processing = false


func process(delta: float) -> State:
	return pass_process(delta)
