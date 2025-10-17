class_name ScoreBoard extends Node2D

var score_mapping: Dictionary = {0: "0", 1: "15", 2: "30", 3: "40"}

@onready var home_name: Label = $GridContainer/HomeName
@onready var away_name: Label = $GridContainer/AwayName
@onready var home_score: Label = $GridContainer/HomeScore
@onready var away_score: Label = $GridContainer/AwayScore


class Score:
	var home_score: int = 0
	var away_score: int = 0

	static func init(_home_score: int, _away_score: int) -> Score:
		var score: Score = Score.new()
		score.home_score = _home_score
		score.away_score = _away_score
		return score

	func reset() -> void:
		home_score = 0
		away_score = 0

	func player_score(home_or_away: String) -> void:
		match home_or_away:
			"home":
				home_score += 1
			"away":
				away_score += 1
			_:
				pass


func reset_score_board() -> void:
	home_score.text = "0"
	away_score.text = "0"


func update_score_board(score: Score) -> void:
	home_score.text = _get_tennis_display_score(score.home_score, score.away_score)
	away_score.text = _get_tennis_display_score(score.away_score, score.home_score)


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
