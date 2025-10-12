class_name PlayerStateOutcome extends StateOutcome

var action: Player.ACTION
var home_or_away: String

var hit_result: Player.HIT_RESULT
var desire_ball_position: Vector2

static func hit_outcome(_action: Player.ACTION, _hit_result: Player.HIT_RESULT, _desire_ball_position: Vector2) -> PlayerStateOutcome:
	var outcome = PlayerStateOutcome.new()
	outcome.action = _action
	outcome.hit_result = _hit_result
	outcome.desire_ball_position = _desire_ball_position
	return outcome

static func run_outcome(_action: Player.ACTION, _home_or_away: String) -> PlayerStateOutcome:
	var outcome = PlayerStateOutcome.new()
	outcome.action = _action
	outcome.home_or_away = _home_or_away
	return outcome
