class_name ScoreBoard extends Node2D

var score_mapping: Dictionary = {0: "0", 1: "15", 2: "30", 3: "40"}

@onready var home_name: Label = $GridContainer/HomeName
@onready var away_name: Label = $GridContainer/AwayName

@onready var home_matches: Label = $GridContainer/HomeMatches
@onready var home_sets: Label = $GridContainer/HomeSets
@onready var home_games: Label = $GridContainer/HomeGames
@onready var home_points: Label = $GridContainer/HomePoints

@onready var away_matches: Label = $GridContainer/AwayMatches
@onready var away_sets: Label = $GridContainer/AwaySets
@onready var away_games: Label = $GridContainer/AwayGames
@onready var away_points: Label = $GridContainer/AwayPoints

# class Score:
# 	var home_score: int = 0
# 	var away_score: int = 0

# 	static func init(_home_score: int, _away_score: int) -> Score:
# 		var score: Score = Score.new()
# 		score.home_score = _home_score
# 		score.away_score = _away_score
# 		return score

# 	func reset() -> void:
# 		home_score = 0
# 		away_score = 0

# 	func player_score(home_or_away: Player.HomeOrAway) -> void:
# 		match home_or_away:
# 			Player.HomeOrAway.HOME:
# 				home_score += 1
# 			Player.HomeOrAway.AWAY:
# 				away_score += 1
# 			_:
# 				pass


func update_score_board(score: SimScore) -> void:
	home_points.text = _get_tennis_display_score(score.home_points, score.away_points)
	away_points.text = _get_tennis_display_score(score.away_points, score.home_points)

	home_games.text = str(score.home_games)
	away_games.text = str(score.away_games)

	home_sets.text = str(score.home_sets)
	away_sets.text = str(score.away_sets)


func _get_tennis_display_score(score: int, opponent_score: int) -> String:
	match score:
		0:
			return "0"
		1:
			return "15"
		2:
			return "30"
		3:
			if opponent_score <= 3:
				return "40"
			return ""
		_:
			if score == opponent_score:
				return "40"
			if score < opponent_score:
				return ""
			return "ad"
