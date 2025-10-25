class_name TennisSetStateIdle extends TennisSetState


func _ready() -> void:
	state_name = TennisSet.StateName.IDLE


func enter() -> void:
	tennis_set.logger.log("tennis set enter idle")
	state_processing = true

func reenter() -> void:
	tennis_set.logger.log("tennis set reenter idle")


func exit() -> void:
	state_processing = false


func process(delta: float) -> State:
	return wait_process(delta)
