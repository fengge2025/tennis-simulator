extends Node2D

@onready var score_board: ScoreBoard = $ScoreBoard
@onready var timer: Timer = $Timer

func _ready() -> void:
	timer.timeout.connect(on_timer_timeout)
	
	var score = ScoreBoard.Score.init(10, 11)
	score_board.update_score_board(score)
	
	timer.start(2)

func on_timer_timeout():
	var score = ScoreBoard.Score.init(100, 110)
	score_board.update_score_board(score)
