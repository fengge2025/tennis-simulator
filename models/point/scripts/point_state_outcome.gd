class_name PointStateOutcome extends StateOutcome

var action: Point.ACTION

static func prepare_outcome(_action: Point.ACTION) -> PointStateOutcome:
	var outcome = PointStateOutcome.new()
	outcome.action = _action
	return outcome