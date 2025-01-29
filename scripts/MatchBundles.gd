extends Node
class_name MatchBundles


class GameScore:
	var current_match_score: Array[int]
	var current_set_score: Array[int]
	var current_game_score: Array[int]

	func _init() -> void:
		current_match_score = [0, 0]
		current_set_score = [0, 0]
		current_game_score = [0, 0]

class Hit:
	var playre: TennisPlayer.Player
	var current: int

class TennisPoint:
	var tennis_game = MatchBundles.TennisGame
	var current: int# 0: server, 1: receiver
		
	func _init(_tennis_game: TennisGame) -> void:
		tennis_game = _tennis_game
		current = 0
	
	func sim_hits() -> int:
		# return winner_idx
		while true:
			var hit_outcome = tennis_game.tennis_match.players[current].hit_ball()
			current ^= 1
			if hit_outcome == TennisPlayer.HitOutcome.MISS:
				tennis_game.tennis_match.outcomes.append("miss")
				return current
			else:
				tennis_game.tennis_match.outcomes.append("hit")
		
		return current

class TennisGame:
	var tennis_match = MatchBundles.TennisMatch
	var current: int # 0: server, 1: receiver
	var score: Array[int]
		
	func _init(_tennis_match: TennisMatch) -> void:
		tennis_match = _tennis_match
		current = 0
		score = [0, 0]
	
	func next_point() -> void:
		pass
		
class TennisMatch:
	var players: Array[TennisPlayer.Player]
	var outcomes: Array[String]
	
	func _init(_players: Array[TennisPlayer.Player]) -> void:
		players = _players
		outcomes = []
