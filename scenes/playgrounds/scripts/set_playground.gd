extends Node

@onready var ball: Ball = $Ball
@onready var player_home: Player = $PlayerHome
@onready var player_away: Player = $PlayerAway
@onready var banner: Banner = $Banner
@onready var score_board: ScoreBoard = $ScoreBoard
@onready var tennis_set: TennisSet = $TennisSet


func _ready() -> void:
	#tennis_set.update_score.connect(_on_set_update_score)

	tennis_set.initialize(banner, ball, player_home, player_away)

	tennis_set.start_set()

#func _on_game_update_score(score: ScoreBoard.Score) -> void:
#score_board.update_score_board(score)
