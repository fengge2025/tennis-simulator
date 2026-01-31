class_name ManagerStateIdle extends ManagerState

func _ready() -> void:
	state_name = Manager.StateName.IDLE

func enter() -> void:
	manager.logger.log("manager enter idle")
	state_processing = true

func reenter() -> void:
	manager.logger.log("manager reenter idle")
func exit() -> void:
	state_processing = false


func process(delta: float) -> State:
	return wait_process(delta)
