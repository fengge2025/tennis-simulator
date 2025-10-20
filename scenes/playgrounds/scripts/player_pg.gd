extends Node

@onready var player: Player = $Player


func _ready() -> void:
	player.action_finished.connect(_on_player_action_finished)

	var v: Vector2 = Vector2(100, 100)
	player.prepare_action(v)


func _on_player_action_finished(outcome: PlayerOutcome) -> void:
	match outcome.action_name:
		Player.ActionName.PREPARE:
			print("player_bg action prepare done")
			var vv: Vector2 = Vector2(350, 350)
			player.hit_and_run_action(vv)
		Player.ActionName.HIT_AND_RUN:
			#ball.idle_action()
			print("player_bg action hit_and_run done")
			var v: Vector2 = Vector2(100, 100)
			player.prepare_action(v)
		_:
			push_error("no action _on_player_action_finished")
