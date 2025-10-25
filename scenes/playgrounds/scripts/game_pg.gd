extends Node

var score: ScoreBoard.Score

@onready var player_home: Player = $PlayerHome
@onready var player_away: Player = $PlayerAway
@onready var ball: Ball = $Ball
@onready var game: Game = $Game
@onready var banner: Banner = $Banner
@onready var score_board: ScoreBoard = $ScoreBoard



func _ready() -> void:
	#player.action_finished.connect(_on_player_action_finished)

	# var v: Vector2 = Vector2(100, 100)
	#player.prepare_action(v)

	game.action_update_score.connect(_on_game_action_update_score)

	score = ScoreBoard.Score.init(0, 0)
	score_board.update_score_board(score)
	
	game.initialize(banner, ball, player_home, player_away)
	
	game.start_game_action()
	

func _on_game_action_update_score(outcome: GameOutcome) -> void:
	# print(123)
	# print(outcome.action_name)
	# print(Game.ActionName.PLAY)
	match outcome.action_name:
		Game.ActionName.PLAY:
			score_board.update_score_board(game.score)
		_:
			pass

#func _on_point_action_finished(outcome: PlayerOutcome) -> void:
	#match outcome.action_name:
		#Player.ActionName.PREPARE:
			#print("_on_point_action_finished action prepare done")
			##var vv: Vector2 = Vector2(350, 350)
			##player.hit_and_run_action(vv)
		#Player.ActionName.HIT_AND_RUN:
			##ball.idle_action()
			#print("_on_point_action_finished action hit_and_run done")
			##var v: Vector2 = Vector2(100, 100)
			##player.prepare_action(v)
		#_:
			#push_error("no action _on_point_action_finished")
