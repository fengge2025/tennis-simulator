class_name SimPoint extends Node

var player_stat: PlayerStat

var player_stat_home: PlayerStat
var player_stat_away: PlayerStat

var receive_turn: int = 0
var hit_player_stat: PlayerStat:
	get:
		if receive_turn == 0:
			return player_stat_home
		return player_stat_away
var receive_player_stat: PlayerStat:
	get:
		if receive_turn == 0:
			return player_stat_away
		return player_stat_home
var hit_home_or_away: Player.HomeOrAway:
	get:
		if receive_turn == 0:
			return Player.HomeOrAway.AWAY
		return Player.HomeOrAway.HOME


static func new_sim_point(_player_stat_home: PlayerStat, _player_stat_away: PlayerStat) -> SimPoint:
	var sim_point: SimPoint = SimPoint.new()
	sim_point.player_stat_home = _player_stat_home
	sim_point.player_stat_away = _player_stat_away
	return sim_point


func start_new_point_action() -> SimPointOutcome:
	var score_home_or_away: Player.HomeOrAway = _start_point()
	var outcome: SimPointOutcome = SimPointOutcome.new_outcome(score_home_or_away)
	return outcome


func _start_point() -> Player.HomeOrAway:
	var end_point: bool = false
	while !end_point:
		end_point = !receive_player_stat.hit_result()
		_swap_players()
	return hit_home_or_away


func _swap_players() -> void:
	receive_turn ^= 1


class SimPointOutcome:
	var score_home_or_away: Player.HomeOrAway

	static func new_outcome(_score_home_or_away: Player.HomeOrAway) -> SimPointOutcome:
		var outcome: SimPointOutcome = SimPointOutcome.new()
		outcome.score_home_or_away = _score_home_or_away
		return outcome
