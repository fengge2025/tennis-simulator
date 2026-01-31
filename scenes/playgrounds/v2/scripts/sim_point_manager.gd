class_name SimPointManager extends Node2D

signal action_finished(action_outcome: SimPointManagerActionOutcome)

enum ActionName { IDLE }
enum StateName { IDLE }

var wait_time: float = 0.3
var home_win_probability: float = 0.5 

var logger: Logger = Logger.initialize("manager")
var rng: RandomNumberGenerator = RandomNumberGenerator.new()

func start_point_action() -> void:
	await get_tree().create_timer(wait_time).timeout
	var action_outcome: SimPointManagerActionOutcome = SimPointManagerActionOutcome.new()
	# Randomly pick HOME or AWAY based on configured probability
	action_outcome.home_or_away = Player.HomeOrAway.HOME if rng.randf() < home_win_probability else Player.HomeOrAway.AWAY
	action_finished.emit(action_outcome)

func _ready() -> void:
	rng.randomize()

class SimPointManagerActionOutcome:
	# var action_name: String
	var home_or_away: Player.HomeOrAway = Player.HomeOrAway.HOME
