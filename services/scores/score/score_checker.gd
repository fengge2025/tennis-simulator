class_name ScoreChecker extends Object


static func _check_point(winner_points: int, loser_points: int) -> bool:
	return winner_points - loser_points > 1 and winner_points > 3


static func _check_game(winner_games: int, loser_games: int) -> bool:
	return winner_games - loser_games > 1 and winner_games > 5


static func _check_set(winner_sets: int, loser_sets: int) -> bool:
	return winner_sets - loser_sets > 1 and winner_sets > 2
