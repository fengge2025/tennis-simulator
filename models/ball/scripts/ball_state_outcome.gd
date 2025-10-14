class_name BallStateOutcome extends StateOutcome

var action: Ball.Action

var ball_destination_position: Vector2


static func run_outcome(
	_action: Ball.Action, _ball_destination_position: Vector2
) -> BallStateOutcome:
	var outcome = BallStateOutcome.new()
	outcome.action = _action
	outcome.ball_destination_position = _ball_destination_position
	return outcome
