class_name SimPoint extends Node

var rng: RandomNumberGenerator = RandomNumberGenerator.new()
var home_win_probability: float = 0.5

func start_rng_point_action() -> SimPointOutcome:
	var outcome: SimPointOutcome = SimPointOutcome.new_outcome(Player.HomeOrAway.HOME if rng.randf() < home_win_probability else Player.HomeOrAway.AWAY)
	return outcome

class SimPointOutcome:
	var score_home_or_away: Player.HomeOrAway

	static func new_outcome(_score_home_or_away: Player.HomeOrAway) -> SimPointOutcome:
		var outcome: SimPointOutcome = SimPointOutcome.new()
		outcome.score_home_or_away = _score_home_or_away
		return outcome
