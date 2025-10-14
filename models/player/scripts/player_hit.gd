class_name PlayerHit extends Object

enum HitResult { HIT, MISS }

var logger: Logger = Logger.initialize("player")

var match_configs: MatchConfig
var player_stat: PlayerStat


func _init(_match_configs: MatchConfig, _player_stat: PlayerStat) -> void:
	match_configs = _match_configs
	player_stat = _player_stat


func get_hit_desire_position() -> Vector2:
	var rand_vec = Vector2(
		randf_range(match_configs["hit_x_min"], match_configs["hit_x_max"]),
		randf_range(match_configs["hit_y_min"], match_configs["hit_y_max"])
	)
	return rand_vec


func get_hit_result() -> HitResult:
	if _get_random_int() < player_stat.hit_point:
		return HitResult.HIT

	return HitResult.MISS


func _get_random_int() -> int:
	randomize()
	return randi_range(0, 20)
