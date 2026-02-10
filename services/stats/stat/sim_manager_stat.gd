class_name SimManagerStat extends Object

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
