class_name PointStateOutcome extends StateOutcome

var action: Point.ACTION

var point_result: Point.POINT_RESULT
var score_home_or_away: String

static func prepare_outcome(_action: Point.ACTION) -> PointStateOutcome:
	var outcome = PointStateOutcome.new()
	outcome.action = _action
	return outcome

static func hit_outcome(_action: Point.ACTION, _score_home_or_away: String) -> PointStateOutcome:
	var outcome = PointStateOutcome.new()
	outcome.action = _action
	outcome.score_home_or_away = _score_home_or_away
	return outcome

static func end_outcome(_action: Point.ACTION, _score_home_or_away: String) -> PointStateOutcome:
	var outcome = PointStateOutcome.new()
	outcome.action = _action
	outcome.score_home_or_away = _score_home_or_away
	return outcome