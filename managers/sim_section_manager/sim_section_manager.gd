class_name SimSectionManager extends Control

var score: Score
var stat: SimManagerStat
var sim_point: SimPoint
var score_home_or_away: Player.HomeOrAway
var sim_match_iter: int
var player_hit_home: int
var player_hit_away: int

@onready var sim_section: SimSection = $SimSection


func initialize(_sim_match_iter: int, _player_hit_home: int, _player_hit_away: int) -> void:
	sim_match_iter = _sim_match_iter
	player_hit_home = _player_hit_home
	player_hit_away = _player_hit_away

	score = Score.new()
	stat = SimManagerStat.new()
	var player_stat_home: PlayerStat = PlayerStat.new_player(player_hit_home, 20, 20)
	var player_stat_away: PlayerStat = PlayerStat.new_player(player_hit_away, 20, 20)
	sim_point = SimPoint.new_sim_point(player_stat_home, player_stat_away)
	sim_section.match_iter = sim_match_iter
	sim_section.home_hit = player_hit_home
	sim_section.away_hit = player_hit_away


func start_sim() -> void:
	for i in range(sim_match_iter):
		start_new_match()
		print(stat)
		await get_tree().create_timer(0.01).timeout


func start_new_point() -> bool:
	var outcome: SimPoint.SimPointOutcome = sim_point.start_new_point_action()
	score_home_or_away = outcome.score_home_or_away
	stat.update_point(score_home_or_away)
	return score.update_point(score_home_or_away)


func start_new_game() -> bool:
	var end_game: bool = false
	while !end_game:
		end_game = start_new_point()
	stat.update_game(score_home_or_away)
	return score.update_game(score_home_or_away)


func start_new_set() -> bool:
	var end_set: bool = false
	while !end_set:
		end_set = start_new_game()
	stat.update_set(score_home_or_away)
	return score.update_set(score_home_or_away)


func start_new_match() -> void:
	var end_match: bool = false
	while !end_match:
		end_match = start_new_set()
	stat.update_match(score_home_or_away)
	sim_section.update_stat(stat)
	score.reset_score()
