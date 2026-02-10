class_name SimSection extends Control

@export var home_hit: int
@export var away_hit: int
@export var match_iter: int:
	set(value):
		match_iter = value
		var cell_unit: int = ceil(match_iter * 0.5 / 10)
		stat_bar_home.cell_unit = cell_unit
		stat_bar_away.cell_unit = cell_unit

@onready var label_home: Label = $GridContainer/LabelHome
@onready var stat_bar_home: StatBar = $GridContainer/StatBarHome
@onready var label_away: Label = $GridContainer/LabelAway
@onready var stat_bar_away: StatBar = $GridContainer/StatBarAway


func update_stat(stat: SimManagerStat) -> void:
	label_home.text = str(home_hit)
	label_away.text = str(away_hit)
	stat_bar_home.update_stat(stat.match_home)
	stat_bar_away.update_stat(stat.match_away)
