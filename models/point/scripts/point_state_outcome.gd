class_name PointStateOutcome extends StateOutcome

var action: Point.Action

var point_result: Point.PointResult
var score_home_or_away: String


static func prepare_outcome(_action: Point.Action) -> PointStateOutcome:
	var outcome: PointStateOutcome = PointStateOutcome.new()
	outcome.action = _action
	return outcome


static func hit_outcome(_action: Point.Action, _score_home_or_away: String) -> PointStateOutcome:
	var outcome: PointStateOutcome = PointStateOutcome.new()
	outcome.action = _action
	outcome.score_home_or_away = _score_home_or_away
	return outcome


static func end_outcome(_action: Point.Action, _score_home_or_away: String) -> PointStateOutcome:
	var outcome: PointStateOutcome = PointStateOutcome.new()
	outcome.action = _action
	outcome.score_home_or_away = _score_home_or_away
	return outcome
