class_name TennisSetStatePlay extends TennisSetState


func _ready() -> void:
	state_name = "play"


func enter() -> void:
	tennis_set.logger.log("tennis set enter play")
	state_processing = true


func exit() -> void:
	state_processing = false


func process(delta: float) -> State:
	return pass_process(delta)
