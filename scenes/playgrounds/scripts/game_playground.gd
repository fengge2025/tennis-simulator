extends Node

@onready var ball: Ball = $Ball
@onready var player_home: Player = $PlayerHome
@onready var player_away: Player = $PlayerAway
@onready var banner: Banner = $Banner
@onready var game: Game = $Game
@onready var score_board: ScoreBoard = $ScoreBoard

func _ready() -> void:
	game.update_score.connect(_on_game_update_score)

	game.initialize(banner, ball, player_home, player_away)

	game.start_game()

func _on_game_update_score(score: ScoreBoard.Score) -> void:
	score_board.update_score_board(score)
