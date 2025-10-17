class_name TennisSetStateIdle extends TennisSetState


func _ready() -> void:
	state_name = "idle"


func enter() -> void:
	tennis_set.logger.log("tennis set enter idle")
	state_processing = true


func exit() -> void:
	state_processing = false


func process(delta: float) -> State:
	return wait_process(delta)
