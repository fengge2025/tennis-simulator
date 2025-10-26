extends Node

var score: Score

#@onready var player_home: Player = $PlayerHome
#@onready var player_away: Player = $PlayerAway
#@onready var ball: Ball = $Ball
#@onready var banner: Banner = $Banner
@onready var score_board: ScoreBoard = $ScoreBoard
#@onready var tennis_set: TennisSet = $TennisSet

func _ready() -> void:
	# score = ScoreBoard.Score.init(0, 0)
	# score_board.update_score_board(score)
	
	score = Score.init(score_board)
	
	var end_game: bool = score.update_point(Player.HomeOrAway.HOME)
	print(score)
	print(end_game)
	end_game = score.update_point(Player.HomeOrAway.HOME)
	print(score)
	print(end_game)
	end_game = score.update_point(Player.HomeOrAway.HOME)
	print(score)
	print(end_game)
	end_game = score.update_point(Player.HomeOrAway.HOME)
	print(score)
	print(end_game)
	end_game = score.update_point(Player.HomeOrAway.HOME)
	print(score)
	print(end_game)
	end_game = score.update_point(Player.HomeOrAway.HOME)
	print(score)
	print(end_game)
	end_game = score.update_point(Player.HomeOrAway.HOME)
	print(score)
	print(end_game)
	end_game = score.update_point(Player.HomeOrAway.HOME)

	# tennis_set.initialize(banner, ball, player_home, player_away)
	
	# tennis_set.start_set_action()
