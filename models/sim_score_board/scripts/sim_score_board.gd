class_name SimScoreBoard extends Node2D

@onready var label_point_home: Label = $GridContainer/LabelPointHome
@onready var label_point_away: Label = $GridContainer/LabelPointAway
@onready var label_game_home: Label = $GridContainer/LabelGameHome
@onready var label_game_away: Label = $GridContainer/LabelGameAway
@onready var label_set_home: Label = $GridContainer/LabelSetHome
@onready var label_set_away: Label = $GridContainer/LabelSetAway
@onready var label_match_home: Label = $GridContainer/LabelMatchHome
@onready var label_match_away: Label = $GridContainer/LabelMatchAway

func update_stat(score: SimManager.SimManagerStat) -> void:
	label_point_home.text = str(score.point_home)
	label_point_away.text = str(score.point_away)
	label_game_home.text = str(score.game_home)
	label_game_away.text = str(score.game_away)
	label_set_home.text = str(score.set_home)
	label_set_away.text = str(score.set_away)
	label_match_home.text = str(score.match_home)
	label_match_away.text = str(score.match_away)
