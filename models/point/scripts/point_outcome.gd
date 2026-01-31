class_name PointOutcome extends Outcome

var action_name: Point.ActionName
var state_name: Point.StateName

var score_home_or_away: Player.HomeOrAway


static func action_end_outcome(_action_name: Point.ActionName, _score_home_or_away: Player.HomeOrAway) -> PointOutcome:
	var outcome: PointOutcome = _action_outcome(_action_name)
	outcome.score_home_or_away = _score_home_or_away
	return outcome

static func state_prepare_outcome(_action_name: Point.ActionName, _state_name: Point.StateName) -> PointOutcome:
	return _state_outcome(_action_name, _state_name)

static func state_play_outcome(_action_name: Point.ActionName, _state_name: Point.StateName) -> PointOutcome:
	return _state_outcome(_action_name, _state_name)

static func state_end_outcome(_action_name: Point.ActionName, _state_name: Point.StateName, _score_home_or_away: Player.HomeOrAway) -> PointOutcome:
	var outcome: PointOutcome = _state_outcome(_action_name, _state_name)
	outcome.score_home_or_away = _score_home_or_away
	return outcome

static func _state_outcome(
	_action_name: Point.ActionName, _state_name: Point.StateName
) -> PointOutcome:
	var outcome: PointOutcome = PointOutcome.new()
	outcome.action_name = _action_name
	outcome.state_name = _state_name
	return outcome


static func _action_outcome(_action_name: Point.ActionName) -> PointOutcome:
	var outcome: PointOutcome = PointOutcome.new()
	outcome.action_name = _action_name
	return outcome
