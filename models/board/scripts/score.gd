class_name Score extends Object

var score_board: ScoreBoard

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

static func init(_score_board: ScoreBoard) -> Score:
	var score: Score = Score.new()
	score.score_board = _score_board
	return score

func reset_scores() -> void:
	home_points = 0
	away_points = 0
	home_games = 0
	away_games = 0
	home_sets = 0
	away_sets = 0
	home_matches = 0
	away_matches = 0

func get_game_winner() -> Player.HomeOrAway:
	if home_points > away_points:
		return Player.HomeOrAway.HOME
	else:
		return Player.HomeOrAway.AWAY


func update_point(winner: Player.HomeOrAway) -> bool:
	match winner:
		Player.HomeOrAway.HOME:
			home_points += 1
			score_board.update_score_board(self)
			return _check_point(home_points, away_points)
		Player.HomeOrAway.AWAY:
			away_points += 1
			score_board.update_score_board(self)
			return _check_point(away_points, home_points)
		_:
			push_error("not a valid winner:", winner)
			return false

func _check_point(winner_points: int, loser_points: int) -> bool:
	return winner_points - loser_points > 1 and winner_points > 3

func update_game(winner: Player.HomeOrAway) -> bool:
	# reset point scores
	home_points = 0
	away_points = 0
	# update game number
	game_num += 1
	match winner:
		Player.HomeOrAway.HOME:
			home_games += 1
			score_board.update_score_board(self)
			return _check_game(home_games, away_games)
		Player.HomeOrAway.AWAY:
			away_games += 1
			score_board.update_score_board(self)
			return _check_game(away_games, home_games)
		_:
			push_error("not a valid winner:", winner)
			return false

func _check_game(winner_games: int, loser_games: int) -> bool:
	return winner_games - loser_games > 1 and winner_games > 5
	
func _to_string() -> String:
	return "Match %d: %d-%d, Set %d: %d-%d, Game %d: %d-%d, Point: %d-%d" % [match_num, home_matches, away_matches, set_num, home_sets, away_sets, game_num, home_games, away_games, home_points, away_points]
