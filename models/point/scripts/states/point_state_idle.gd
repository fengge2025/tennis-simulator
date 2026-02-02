class_name PointStateIdle extends PointState


func _ready() -> void:
	state_name = Point.StateName.IDLE


func enter() -> void:
	point.logger.log("point enter idle")
	state_processing = true


func reenter() -> void:
	point.logger.log("point reenter idle")


func exit() -> void:
	state_processing = false


func process(delta: float) -> State:
	return _wait_process(delta)
