class_name PlayerStat extends Object

const MAX_POINT: float = 20.0

var hit: int = 0
var run: int = 0
var serve: int = 0

var rng: RandomNumberGenerator = RandomNumberGenerator.new()


static func new_player(_hit: int, _run: int, _serve: int) -> PlayerStat:
	var player_stat: PlayerStat = PlayerStat.new()
	player_stat.hit = _hit
	player_stat.run = _run
	player_stat.serve = _serve
	return player_stat


func hit_result() -> bool:
	return rng.randf() < hit / MAX_POINT
