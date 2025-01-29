extends Control
class_name ScoreboadLabel

@onready var first_player_score_lbl = $FirstPlayerScoreLabel
@onready var second_player_score_lbl = $SecondPlayerScoreLabel

const GAME_SCORES = ["0", "15", "30", "40", " ", "AD"]


func reset_scores() -> void:
	first_player_score_lbl.text = "Nimish: 0"  # Initial text
	second_player_score_lbl.text = "Freddy: 0"


func update_scores(game_score: MatchBundles.GameScore) -> void:
	first_player_score_lbl.text = _format_string("Nimish", game_score, 0)
	second_player_score_lbl.text = _format_string("Freddy", game_score, 1)


func _get_game_score_display(score: int, opponent_score: int) -> String:
	if score < 3:
		return GAME_SCORES[score]  # 0 15 30

	if score == 3 and opponent_score < 4:
		return GAME_SCORES[3]

	if score > opponent_score:
		return GAME_SCORES[5]  # "AD"
	elif score < opponent_score:
		return GAME_SCORES[4]  # " "
	else:
		return GAME_SCORES[3]  # 30


func _format_string(
	player_name: String, game_score: MatchBundles.GameScore, player_idx: int
) -> String:
	var score = game_score.current_game_score[player_idx]
	var opponent_score = game_score.current_game_score[player_idx ^ 1]
	return (
		"%s: %s - %s - %s"
		% [
			player_name,
			game_score.current_match_score[player_idx],
			game_score.current_set_score[player_idx],
			_get_game_score_display(score, opponent_score)
		]
	)
