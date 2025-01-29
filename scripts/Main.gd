extends Node2D

# 引用节点
@onready var tennis_ball = $TennisBallAnimatedSprite2D

@onready var btn_reset = $btn_reset

@onready var scoreboard_ctl = $ScoreboardControl

@onready var rtl_outcomes = $OutcomeRichTextLabel

var nimish_stat = TennisPlayer.PlayerStat.new(1, 9)
var nimish = TennisPlayer.Player.new("nimish", nimish_stat)

var freddy_stat = TennisPlayer.PlayerStat.new(1, 9)
var freddy = TennisPlayer.Player.new("freddy", freddy_stat)

var game_score = MatchBundles.GameScore.new()
var players = [nimish, freddy]
#var match = MatchBundles.TennisMatch

#var scoreboard = Scoreboard.new(first_player_score_lbl, second_player_score_lbl)
var outcomes = []

enum TurnState { FIRST_PLAYER, SECOND_PLAYER }
var turn_state = TurnState.FIRST_PLAYER
var ball_points = [Vector2(400, 100), Vector2(200, 400)]

func next_turn():
	if turn_state == TurnState.FIRST_PLAYER:
		print("Fisrt Player's Turn")
		await fisrt_player_action()
	elif turn_state == TurnState.SECOND_PLAYER:
		print("Second Player's Turn")
		await second_player_action()
	next_turn()
		
func fisrt_player_action():
	turn_state = TurnState.SECOND_PLAYER
	await move_sprite(Vector2(400, 100))
	nimish.hit_ball()

func second_player_action():
	turn_state = TurnState.FIRST_PLAYER
	await move_sprite(Vector2(200, 400))
	freddy.hit_ball()

func _ready():
	tennis_ball.play("fly")
	next_turn()

func move_sprite(target_position: Vector2):
	var tween = create_tween()  # Create a Tween instance
	tween.tween_property(tennis_ball, "position", target_position, 1.0).set_trans(Tween.TRANS_QUAD)
	await tween.finished  # Wait until the movement is complete
	print("Movement finished!")
