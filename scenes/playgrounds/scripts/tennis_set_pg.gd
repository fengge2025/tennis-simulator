extends Node

var score: ScoreBoard.Score

@onready var player_home: Player = $PlayerHome
@onready var player_away: Player = $PlayerAway
@onready var ball: Ball = $Ball
@onready var banner: Banner = $Banner
@onready var score_board: ScoreBoard = $ScoreBoard
@onready var tennis_set: TennisSet = $TennisSet

func _ready() -> void:
	score = ScoreBoard.Score.init(0, 0)
	score_board.update_score_board(score)
	
	tennis_set.initialize(banner, ball, player_home, player_away)
	
	tennis_set.start_set_action()
