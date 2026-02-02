class_name PlayerOutcome extends Outcome


class PlayerActionOutcome:
	extends Outcome
	var action_name: Player.ActionName

	static func new_outcome(_action_name: Player.ActionName) -> PlayerActionOutcome:
		var outcome: PlayerActionOutcome = PlayerActionOutcome.new()
		outcome.action_name = _action_name
		return outcome


class PlayerActionPrepareOutcome:
	extends PlayerActionOutcome
	var home_or_away: Player.HomeOrAway

	static func new_prepare_outcome(_home_or_away: Player.HomeOrAway) -> PlayerActionPrepareOutcome:
		var outcome: PlayerActionPrepareOutcome = PlayerActionPrepareOutcome.new()
		outcome.action_name = Player.ActionName.PREPARE
		outcome.home_or_away = _home_or_away
		return outcome


class PlayerActionHitOutcome:
	extends PlayerActionOutcome
	var home_or_away: Player.HomeOrAway
	var hit_result: PlayerHit.HitResult
	var ball_destination_position: Vector2

	static func new_hit_outcome(
		_home_or_away: Player.HomeOrAway,
		_hit_result: PlayerHit.HitResult,
		_ball_destination_position: Vector2
	) -> PlayerActionHitOutcome:
		var outcome: PlayerActionHitOutcome = PlayerActionHitOutcome.new()
		outcome.action_name = Player.ActionName.HIT
		outcome.home_or_away = _home_or_away
		outcome.hit_result = _hit_result
		outcome.ball_destination_position = _ball_destination_position
		return outcome


class PlayerStateOutcome:
	extends Outcome
	var state_name: Player.StateName
	var action_name: Player.ActionName

	static func new_outcome(
		_state_name: Player.StateName, _action_name: Player.ActionName
	) -> PlayerStateOutcome:
		var outcome: PlayerStateOutcome = PlayerStateOutcome.new()
		outcome.state_name = _state_name
		outcome.action_name = _action_name
		return outcome


class PlayerStateHitOutcome:
	extends PlayerStateOutcome

	static func new_hit_outcome() -> PlayerStateHitOutcome:
		var outcome: PlayerStateHitOutcome = PlayerStateHitOutcome.new()
		outcome.state_name = Player.StateName.HIT
		outcome.action_name = Player.ActionName.HIT
		return outcome


class PlayerStateRunOutcome:
	extends PlayerStateOutcome
	var target_position: Vector2

	static func new_run_outcome(
		_action_name: Player.ActionName, _target_position: Vector2
	) -> PlayerStateRunOutcome:
		var outcome: PlayerStateRunOutcome = PlayerStateRunOutcome.new()
		outcome.state_name = Player.StateName.RUN
		outcome.action_name = _action_name
		outcome.target_position = _target_position
		return outcome
