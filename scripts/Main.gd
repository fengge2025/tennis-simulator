extends Node2D

@onready var tennis_ball_spr = $TennisBallAnimatedSprite2D
@onready var reset_btn = $ResetButton
@onready var scoreboard_ctl = $ScoreboardControl
@onready var outcome_rtl = $OutcomeRichTextLabel

var tennis_match = MatchBundles.TennisMatch.new()

enum TurnState { FIRST_PLAYER, SECOND_PLAYER }
var turn_state = TurnState.FIRST_PLAYER

var target_positions = [Vector2(400, 100), Vector2(200, 400)]


func next_turn():
	await player_action()
	scoreboard_ctl.update_scores(tennis_match.game_score)

	next_turn()


func player_action():
	await move_sprite(target_positions[turn_state])
	turn_state ^= 1
	var start_serve = tennis_match.next_hit(turn_state)
	if start_serve:
		await move_sprite(Vector2(380, 110))
		await get_tree().create_timer(0.5).timeout


func _ready():
	tennis_ball_spr.play("fly")
	next_turn()


func move_sprite(target_position: Vector2):
	var tween = create_tween()
	tween.tween_property(tennis_ball_spr, "position", target_position, 1.0).set_trans(
		Tween.TRANS_QUAD
	)
	await tween.finished
