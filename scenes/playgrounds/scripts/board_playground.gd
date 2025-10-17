extends Node2D

var score: ScoreBoard.Score
var idx: int = 0
var home_or_away: Array[String] = ["home", "away"]

@onready var score_board: ScoreBoard = $ScoreBoard
@onready var timer: Timer = $Timer


func _ready() -> void:
	timer.timeout.connect(on_timer_timeout)

	score = ScoreBoard.Score.init(0, 0)
	score_board.update_score_board(score)

	timer.start(1)


func on_timer_timeout() -> void:
	score.player_score(home_or_away[idx])
	idx ^= 1
	score_board.update_score_board(score)
	#timer.stop()
	timer.start(1)
