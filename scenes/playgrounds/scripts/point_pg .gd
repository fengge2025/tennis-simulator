extends Node

@onready var player_home: Player = $PlayerHome
@onready var player_away: Player = $PlayerAway
@onready var ball: Ball = $Ball
@onready var point: Point = $Point
@onready var banner: Banner = $Banner


func _ready() -> void:
	#player.action_finished.connect(_on_player_action_finished)

	# var v: Vector2 = Vector2(100, 100)
	#player.prepare_action(v)
	point.initialize(banner, ball, player_home, player_away)
	
	point.start_point_action()
	


func _on_point_action_finished(outcome: PlayerOutcome) -> void:
	match outcome.action_name:
		Player.ActionName.PREPARE:
			print("_on_point_action_finished action prepare done")
			#var vv: Vector2 = Vector2(350, 350)
			#player.hit_and_run_action(vv)
		Player.ActionName.HIT_AND_RUN:
			#ball.idle_action()
			print("_on_point_action_finished action hit_and_run done")
			#var v: Vector2 = Vector2(100, 100)
			#player.prepare_action(v)
		_:
			push_error("no action _on_point_action_finished")
