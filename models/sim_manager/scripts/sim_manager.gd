class_name SimManager extends Node2D

enum ActionName { IDLE }
enum StateName { IDLE }

var logger: Logger = Logger.initialize("sim_manager")

var current_action: ActionName = ActionName.IDLE

var score: Score
var stat: SimManagerStat
var sim_point: SimPoint
var score_home_or_away: Player.HomeOrAway

@onready var timer: Timer = $Timer
@onready var sim_score_board: SimScoreBoard = $SimScoreBoard

func initialize() -> void:
	score = Score.new()
	stat = SimManagerStat.new()
	sim_point = SimPoint.new()

func start_sim() -> void:
	for i in range(30):
		start_new_match()
		await get_tree().create_timer(0.01).timeout

func start_new_point() -> bool:
	var outcome: SimPoint.SimPointOutcome = sim_point.start_rng_point_action()
	score_home_or_away = outcome.score_home_or_away
	stat.update_point(score_home_or_away)
	return score.update_point(score_home_or_away)

func start_new_game() -> bool:
	var end_game: bool = false
	while !end_game:
		end_game = start_new_point()
	stat.update_game(score_home_or_away)
	return score.update_game(score_home_or_away)

func start_new_set() -> bool:
	var end_set: bool = false
	while !end_set:
		end_set = start_new_game()
	stat.update_set(score_home_or_away)
	#sim_score_board.update_stat(stat)
	return score.update_set(score_home_or_away)

func start_new_match() -> void:
	var end_match: bool = false
	while !end_match:
		end_match = start_new_set()
	stat.update_match(score_home_or_away)
	sim_score_board.update_stat(stat)
	score.reset_score()


class SimManagerStat:
	var point_home: int = 0
	var point_away: int = 0
	var game_home: int = 0
	var game_away: int = 0
	var set_home: int = 0
	var set_away: int = 0
	var match_home: int = 0
	var match_away: int = 0

	func update_point(winner: Player.HomeOrAway) -> void:
		match winner:
			Player.HomeOrAway.HOME:
				point_home += 1
			Player.HomeOrAway.AWAY:
				point_away += 1
			_:
				push_error("not a valid winner:", winner)

	func update_game(winner: Player.HomeOrAway) -> void:
		match winner:
			Player.HomeOrAway.HOME:
				game_home += 1
			Player.HomeOrAway.AWAY:
				game_away += 1
			_:
				push_error("not a valid winner:", winner)

	func update_set(winner: Player.HomeOrAway) -> void:
		match winner:
			Player.HomeOrAway.HOME:
				set_home += 1
			Player.HomeOrAway.AWAY:
				set_away += 1
			_:
				push_error("not a valid winner:", winner)

	func update_match(winner: Player.HomeOrAway) -> void:
		match winner:
			Player.HomeOrAway.HOME:
				match_home += 1
			Player.HomeOrAway.AWAY:
				match_away += 1
			_:
				push_error("not a valid winner:", winner)

	func _to_string() -> String:
		return (
		"Match %d: %d-%d, Set %d: %d-%d, Game %d: %d-%d, Point %d: %d-%d"
		% [
			match_home + match_away,
			match_home,
			match_away,
			set_home + set_away,
			set_home,
			set_away,
			game_home + game_away,
			game_home,
			game_away,
			point_home + point_away,
			point_home,
			point_away
		]
	)
