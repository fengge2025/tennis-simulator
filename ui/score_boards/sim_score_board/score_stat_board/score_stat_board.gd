class_name ScoreStatBoard extends Control

@export var label_text: String:
	set(value):
		label_text = value
		label.text = value
@export var cell_unit: int:
	set(value):
		cell_unit = value
		stat_bar_home.cell_unit = value
		stat_bar_away.cell_unit = value

@onready var label: Label = $Label
@onready var stat_bar_home: StatBar = $VBoxContainerStatBar/StatBarHome
@onready var stat_bar_away: StatBar = $VBoxContainerStatBar/StatBarAway
@onready var label_home_number: Label = $GridContainerStatNumber/LabelHomeNumber
@onready var label_home_percentage: Label = $GridContainerStatNumber/LabelHomePercentage
@onready var label_away_number: Label = $GridContainerStatNumber/LabelAwayNumber
@onready var label_away_percentage: Label = $GridContainerStatNumber/LabelAwayPercentage


func update_stat(home_stat: int, away_stat: int) -> void:
	var percentage: Vector2 = cal_percentage(home_stat, away_stat)
	stat_bar_home.update_stat(home_stat)
	label_home_number.text = str(home_stat)
	label_home_percentage.text = "%d%%" % percentage.x

	stat_bar_away.update_stat(away_stat)
	label_away_number.text = str(away_stat)
	label_away_percentage.text = "%d%%" % percentage.y


func cal_percentage(home_stat: int, away_stat: int) -> Vector2:
	var total_stat: int = home_stat + away_stat
	var home_percentage: int = ceil(home_stat * 100.0 / total_stat)
	var away_percentage: int = 100 - home_percentage
	return Vector2(home_percentage, away_percentage)
