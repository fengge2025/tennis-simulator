class_name PointStateIdle extends PointState


func _ready() -> void:
	state_name = "idle"


func enter() -> void:
	point.logger.log("point enter idle")
	state_processing = true


func exit() -> void:
	state_processing = false


func process(delta: float) -> State:
	return wait_process(delta)
