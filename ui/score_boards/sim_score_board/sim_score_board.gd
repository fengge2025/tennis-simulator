class_name SimScoreBoard extends Control

@export var match_iter: int:
	set(value):
		match_iter = value
		score_stat_board_point.cell_unit = ceil(match_iter * 15.0 / 10)
		score_stat_board_game.cell_unit = ceil(match_iter * 5.0 / 10)
		score_stat_board_set.cell_unit = ceil(match_iter * 1.5 / 10)
		score_stat_board_match.cell_unit = ceil(match_iter * 0.5 / 10)

@onready var score_stat_board_point: ScoreStatBoard = $VBoxContainer/ScoreStatBoardPoint
@onready var score_stat_board_game: ScoreStatBoard = $VBoxContainer/ScoreStatBoardGame
@onready var score_stat_board_set: ScoreStatBoard = $VBoxContainer/ScoreStatBoardSet
@onready var score_stat_board_match: ScoreStatBoard = $VBoxContainer/ScoreStatBoardMatch


func _ready() -> void:
	score_stat_board_point.label_text = "point"
	score_stat_board_game.label_text = "game"
	score_stat_board_set.label_text = "set"
	score_stat_board_match.label_text = "match"


func update_stat(score: SimManager.SimManagerStat) -> void:
	score_stat_board_point.update_stat(score.point_home, score.point_away)
	score_stat_board_game.update_stat(score.game_home, score.game_away)
	score_stat_board_set.update_stat(score.set_home, score.set_away)
	score_stat_board_match.update_stat(score.match_home, score.match_away)
