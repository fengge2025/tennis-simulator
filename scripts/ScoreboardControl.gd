extends Control
class_name ScoreboadLabel

@onready var first_player_score_lbl = $FirstPlayerScoreLabel
@onready var second_player_score_lbl = $SecondPlayerScoreLabel


func reset_scores() -> void:
	first_player_score_lbl.text = "Nimish: 0"  # Initial text
	second_player_score_lbl.text = "Freddy: 0"


func update_scores(game_score: MatchBundles.GameScore) -> void:
	first_player_score_lbl.text = _format_string("Nimish", game_score, 0)
	second_player_score_lbl.text = _format_string("Freddy", game_score, 1)


func _format_string(
	player_name: String, game_score: MatchBundles.GameScore, player_idx: int
) -> String:
	return (
		"%s: %s - %s - %s"
		% [
			player_name,
			game_score.current_match_score[player_idx],
			game_score.current_set_score[player_idx],
			game_score.current_game_score[player_idx]
		]
	)
