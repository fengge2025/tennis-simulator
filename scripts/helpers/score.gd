class_name Score extends Object

var home_points: int = 0
var away_points: int = 0
var home_games: int = 0
var away_games: int = 0
var home_sets: int = 0
var away_sets: int = 0

var game_num: int = 1
var set_num: int = 1
var match_num: int = 1

func update_point(winner: Player.HomeOrAway) -> bool:
	match winner:
		Player.HomeOrAway.HOME:
			home_points += 1
			return ScoreChecker._check_point(home_points, away_points)
		Player.HomeOrAway.AWAY:
			away_points += 1
			return ScoreChecker._check_point(away_points, home_points)
		_:
			push_error("not a valid winner:", winner)
			return false


func clean_point() -> void:
	home_points = 0
	away_points = 0


func update_game(winner: Player.HomeOrAway) -> bool:
	match winner:
		Player.HomeOrAway.HOME:
			home_games += 1
			return ScoreChecker._check_game(home_games, away_games)
		Player.HomeOrAway.AWAY:
			away_games += 1
			return ScoreChecker._check_game(away_games, home_games)
		_:
			push_error("not a valid winner:", winner)
			return false


func clean_game() -> void:
	home_games = 0
	away_games = 0


func update_set(winner: Player.HomeOrAway) -> bool:
	match winner:
		Player.HomeOrAway.HOME:
			home_sets += 1
			return ScoreChecker._check_set(home_sets, away_sets)
		Player.HomeOrAway.AWAY:
			away_sets += 1
			return ScoreChecker._check_set(away_sets, home_sets)
		_:
			push_error("not a valid winner:", winner)
			return false


func clean_set() -> void:
	home_sets = 0
	away_sets = 0

func reset_score() -> void:
	clean_point()
	clean_game()
	clean_set()

func _to_string() -> String:
	return (
		"Set %d: %d-%d, Game %d: %d-%d, Point: %d-%d"
		% [
			set_num,
			home_sets,
			away_sets,
			game_num,
			home_games,
			away_games,
			home_points,
			away_points
		]
	)
