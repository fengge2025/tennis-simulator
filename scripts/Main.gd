extends Node2D

# 网球的速度
@export var ball_speed_hrz: float = 200.0
@export var ball_speed_vrt: float = 400.0
var ball_direction = 1  # 方向：1 表示向右，-1 表示向左

# 引用节点
@onready var tennis_ball = $TennisBallAnimatedSprite2D

@onready var btn_reset = $btn_reset

@onready var scoreboard_ctl = $ScoreboardControl

var nimish_stat = TennisPlayer.PlayerStat.new(1, 9)
var nimish = TennisPlayer.Player.new("nimish", nimish_stat)

var freddy_stat = TennisPlayer.PlayerStat.new(1, 9)
var freddy = TennisPlayer.Player.new("freddy", freddy_stat)

var game_score = TennisMatch.GameScore.new()
var players = [nimish, freddy]

#var scoreboard = Scoreboard.new(first_player_score_lbl, second_player_score_lbl)


func _ready():
	# 初始化网球位置
	tennis_ball.play("fly")
	tennis_ball.position = Vector2(323, 94)  # 屏幕中央

	scoreboard_ctl.reset_scores()


func _process(delta):
	# 更新网球的 x 坐标
	tennis_ball.position.x += ball_speed_hrz * ball_direction * delta
	tennis_ball.position.y += ball_speed_vrt * -ball_direction * delta

	# 如果网球到达屏幕左右边界
	if tennis_ball.position.x <= 200 or tennis_ball.position.x >= 343:
		ball_direction *= -1  # 改变方向

		#var nimish_stat = TennisPlayer.PlayerStat.new(1, 9)
		#var nimish = TennisPlayer.Player.new("nimish", nimish_stat)
		#
		#var freddy_stat = TennisPlayer.PlayerStat.new(1, 9)
		#var freddy = TennisPlayer.Player.new("freddy", freddy_stat)
		#
		var outcome = nimish.hit_ball()
		if outcome == TennisPlayer.HitOutcome.CONT:
			game_score.current_game_score[0] += 1
		else:
			game_score.current_game_score[1] += 1

		scoreboard_ctl.update_scores(game_score)

		#first_player_score_lbl.text = "Nimish: " + str(game_score.scores[0])  # Initial text
		#second_player_score_lbl.text = "Freddy: " + str(game_score.scores[1])


func reset_game():
	# 重置球位置和计数器
	#tennis_ball.position = Vector2(323, 94)  # 屏幕中央
	#ball_direction = 1  # 恢复初始方向
	#scores = [0, 0]  # 重置计数器
	#first_player_score_lbl.text = "Score: " + str(scores[0])  # Initial text
	#second_player_score_lbl.text = "Score: " + str(scores[1])

	get_tree().reload_current_scene()
	#print("1")


func _on_btn_reset_pressed() -> void:
	reset_game()


func _on_btn_reset_button_up() -> void:
	pass  # Replace with function body.
