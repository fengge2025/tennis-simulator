class_name ManagerOutcome extends Outcome

var action_name: Manager.ActionName
var state_name: Manager.StateName

static func _state_outcome(
	_action_name: Manager.ActionName, _state_name: Manager.StateName
) -> ManagerOutcome:
	var outcome: ManagerOutcome = ManagerOutcome.new()
	outcome.action_name = _action_name
	outcome.state_name = _state_name
	return outcome


static func _action_outcome(_action_name: Manager.ActionName) -> ManagerOutcome:
	var outcome: ManagerOutcome = ManagerOutcome.new()
	outcome.action_name = _action_name
	return outcome
