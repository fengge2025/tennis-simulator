class_name PlayerHit extends Object

var logger: Logger = Logger.initialize("player")

enum HIT_RESULT {HIT, MISS}

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

func get_hit_result() -> HIT_RESULT:
	if _get_random_int() < player_stat.hit_point:
		return HIT_RESULT.HIT
	else:
		return HIT_RESULT.MISS

func _get_random_int() -> int:
	randomize()
	return randi_range(0, 20)
