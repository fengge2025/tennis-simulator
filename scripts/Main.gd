extends Node2D

@onready var tennis_ball_spr = $TennisBallAnimatedSprite2D
@onready var reset_btn = $ResetButton
@onready var scoreboard_ctl = $ScoreboardControl
@onready var outcome_rtl = $OutcomeRichTextLabel

var tennis_match = MatchBundles.TennisMatch.new()

enum TurnState { FIRST_PLAYER, SECOND_PLAYER }
var turn_state = TurnState.FIRST_PLAYER

func next_turn():
	if turn_state == TurnState.FIRST_PLAYER:
		await fisrt_player_action()
	elif turn_state == TurnState.SECOND_PLAYER:
		await second_player_action()
	
	scoreboard_ctl.update_scores(tennis_match.game_score)	
	
	next_turn()
		
func fisrt_player_action():
	turn_state ^= 1
	await move_sprite(Vector2(400, 100))
	#tennis_match.first_player.hit_ball()
	tennis_match.next_hit(turn_state)

func second_player_action():
	turn_state ^= 1
	await move_sprite(Vector2(200, 400))
	#tennis_match.second_player.hit_ball()
	tennis_match.next_hit(turn_state)

func _ready():
	tennis_ball_spr.play("fly")
	next_turn()

func move_sprite(target_position: Vector2):
	var tween = create_tween()  # Create a Tween instance
	tween.tween_property(tennis_ball_spr, "position", target_position, 1.0).set_trans(Tween.TRANS_QUAD)
	await tween.finished  # Wait until the movement is complete
