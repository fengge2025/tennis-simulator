class_name PointOutcome extends Outcome

var action_name: Point.ActionName
var state_name: Point.StateName

static func action_prepare_outcome(_action_name: Point.ActionName) -> PointOutcome:
	return _action_outcome(_action_name)


static func action_run_outcome(_action_name: Point.ActionName) -> PointOutcome:
	return _action_outcome(_action_name)


static func state_prepare_outcome(_action_name: Point.ActionName, _state_name: Point.StateName) -> PointOutcome:
	return _state_outcome(_action_name, _state_name)

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
