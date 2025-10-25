class_name PlayerOutcome extends Outcome

var action_name: Player.ActionName
var state_name: Player.StateName

var target_position: Vector2
var home_or_away: Player.HomeOrAway
var hit_result: PlayerHit.HitResult
var ball_destination_position: Vector2


static func state_run_outcome(
	_action_name: Player.ActionName, _state_name: Player.StateName, _target_position: Vector2
) -> PlayerOutcome:
	var outcome: PlayerOutcome = _state_outcome(_action_name, _state_name)
	outcome.target_position = _target_position
	return outcome


static func action_prepare_outcome(_action_name: Player.ActionName, _home_or_away: Player.HomeOrAway) -> PlayerOutcome:
	var outcome: PlayerOutcome = _action_outcome(_action_name)
	outcome.home_or_away = _home_or_away
	return outcome


static func action_run_outcome(_action_name: Player.ActionName) -> PlayerOutcome:
	return _action_outcome(_action_name)


static func action_hit_and_run_outcome(_action_name: Player.ActionName, _home_or_away: Player.HomeOrAway, _hit_result: PlayerHit.HitResult, _ball_destination_position: Vector2) -> PlayerOutcome:
	var outcome: PlayerOutcome =  _action_outcome(_action_name)
	outcome.hit_result = _hit_result
	outcome.ball_destination_position = _ball_destination_position
	outcome.home_or_away = _home_or_away
	return outcome


static func _state_outcome(
	_action_name: Player.ActionName, _state_name: Player.StateName
) -> PlayerOutcome:
	var outcome: PlayerOutcome = PlayerOutcome.new()
	outcome.action_name = _action_name
	outcome.state_name = _state_name
	return outcome


static func _action_outcome(_action_name: Player.ActionName) -> PlayerOutcome:
	var outcome: PlayerOutcome = PlayerOutcome.new()
	outcome.action_name = _action_name
	return outcome
