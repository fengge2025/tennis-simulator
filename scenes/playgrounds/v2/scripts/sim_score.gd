class_name SimScore extends Object

var home_points: int = 0
var away_points: int = 0
var home_games: int = 0
var away_games: int = 0
var home_sets: int = 0
var away_sets: int = 0
var home_matches: int = 0
var away_matches: int = 0

var game_num: int = 1
var set_num: int = 1
var match_num: int = 1

static func init() -> SimScore:
	var score: SimScore = SimScore.new()
	return score

func update_point(winner: Player.HomeOrAway) -> bool:
	match winner:
		Player.HomeOrAway.HOME:
			home_points += 1
			return _check_point(home_points, away_points)
		Player.HomeOrAway.AWAY:
			away_points += 1
			return _check_point(away_points, home_points)
		_:
			push_error("not a valid winner:", winner)
			return false

func clean_point() -> void:
	home_points = 0
	away_points = 0

func _check_point(winner_points: int, loser_points: int) -> bool:
	return winner_points - loser_points > 1 and winner_points > 3

func update_game(winner: Player.HomeOrAway) -> bool:
	match winner:
		Player.HomeOrAway.HOME:
			home_games += 1
			return _check_game(home_games, away_games)
		Player.HomeOrAway.AWAY:
			away_games += 1
			return _check_game(away_games, home_games)
		_:
			push_error("not a valid winner:", winner)
			return false

func clean_game() -> void:
	home_games = 0
	away_games = 0

func _check_game(winner_games: int, loser_games: int) -> bool:
	return winner_games - loser_games > 1 and winner_games > 5


func update_set(winner: Player.HomeOrAway) -> bool:
	match winner:
		Player.HomeOrAway.HOME:
			home_sets += 1
			return _check_set(home_sets, away_sets)
		Player.HomeOrAway.AWAY:
			away_sets += 1
			return _check_set(away_sets, home_sets)
		_:
			push_error("not a valid winner:", winner)
			return false

func _check_set(winner_sets: int, loser_sets: int) -> bool:
	return winner_sets - loser_sets > 1 and winner_sets > 2

func clean_set() -> void:
	home_sets = 0
	away_sets = 0