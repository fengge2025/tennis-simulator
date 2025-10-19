class_name BallOutcome extends Outcome

var action_name: Ball.ActionName
var state_name: Ball.StateName

var target_position: Vector2


static func state_run_outcome(_action_name: Ball.ActionName, _state_name: Ball.StateName, _target_position: Vector2) -> BallOutcome:
	var outcome: BallOutcome = _state_outcome(_action_name, _state_name)
	outcome.target_position = _target_position
	return outcome

static func action_prepare_outcome(_action_name: Ball.ActionName) -> BallOutcome:
	return _action_outcome(_action_name)

static func action_run_outcome(_action_name: Ball.ActionName) -> BallOutcome:
	return _action_outcome(_action_name)
	
static func _state_outcome(_action_name: Ball.ActionName, _state_name: Ball.StateName) -> BallOutcome:
	var outcome: BallOutcome = BallOutcome.new()
	outcome.action_name = _action_name
	outcome.state_name = _state_name
	return outcome 
	
static func _action_outcome(_action_name: Ball.ActionName) -> BallOutcome:
	var outcome: BallOutcome = BallOutcome.new()
	outcome.action_name = _action_name
	return outcome
