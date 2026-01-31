extends Node

var score: Score

@onready var player_home: Player = $PlayerHome
@onready var player_away: Player = $PlayerAway
@onready var ball: Ball = $Ball
@onready var banner: Banner = $Banner
@onready var score_board: ScoreBoard = $ScoreBoard
@onready var tennis_set: TennisSet = $TennisSet

func _ready() -> void:
	# score = ScoreBoard.Score.init(0, 0)
	# score_board.update_score_board(score)
	
	score = Score.init(score_board)

	tennis_set.initialize(banner, ball, player_home, player_away, score)
	
	tennis_set.start_set_action()
