class_name PlayerStat extends Object

var hit_point: int = 0
var run_point: int = 0
var serve_point: int = 0

func _init(_hit_point: int, _run_point: int, _serve_point: int) -> void:
	hit_point = _hit_point
	run_point = _run_point
	serve_point = _serve_point