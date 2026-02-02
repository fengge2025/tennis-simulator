class_name PointOutcome extends Outcome

# var action_name: Point.ActionName
# var state_name: Point.StateName

# var score_home_or_away: Player.HomeOrAway

# static func action_end_outcome(
# 	_action_name: Point.ActionName, _score_home_or_away: Player.HomeOrAway
# ) -> PointOutcome:
# 	var outcome: PointOutcome = _action_outcome(_action_name)
# 	outcome.score_home_or_away = _score_home_or_away
# 	return outcome

# static func state_prepare_outcome(
# 	_action_name: Point.ActionName, _state_name: Point.StateName
# ) -> PointOutcome:
# 	return _state_outcome(_action_name, _state_name)

# static func state_play_outcome(
# 	_action_name: Point.ActionName, _state_name: Point.StateName
# ) -> PointOutcome:
# 	return _state_outcome(_action_name, _state_name)

# static func state_end_outcome(
# 	_action_name: Point.ActionName,
# 	_state_name: Point.StateName,
# 	_score_home_or_away: Player.HomeOrAway
# ) -> PointOutcome:
# 	var outcome: PointOutcome = _state_outcome(_action_name, _state_name)
# 	outcome.score_home_or_away = _score_home_or_away
# 	return outcome

# static func _state_outcome(
# 	_action_name: Point.ActionName, _state_name: Point.StateName
# ) -> PointOutcome:
# 	var outcome: PointOutcome = PointOutcome.new()
# 	outcome.action_name = _action_name
# 	outcome.state_name = _state_name
# 	return outcome

# static func _action_outcome(_action_name: Point.ActionName) -> PointOutcome:
# 	var outcome: PointOutcome = PointOutcome.new()
# 	outcome.action_name = _action_name
# 	return outcome


class PointActionOutcome:
	extends Outcome
	var action_name: Point.ActionName

	static func new_outcome(_action_name: Point.ActionName) -> PointActionOutcome:
		var outcome: PointActionOutcome = PointActionOutcome.new()
		outcome.action_name = _action_name
		return outcome


class PointActionEndOutcome:
	extends PointActionOutcome
	var score_home_or_away: Player.HomeOrAway

	static func new_end_outcome(_score_home_or_away: Player.HomeOrAway) -> PointActionEndOutcome:
		var outcome: PointActionEndOutcome = PointActionEndOutcome.new()
		outcome.action_name = Point.ActionName.END
		outcome.score_home_or_away = _score_home_or_away
		return outcome


class PointStateOutcome:
	extends Outcome
	var state_name: Point.StateName
	var action_name: Point.ActionName

	static func new_outcome(
		_state_name: Point.StateName, _action_name: Point.ActionName
	) -> PointStateOutcome:
		var outcome: PointStateOutcome = PointStateOutcome.new()
		outcome.state_name = _state_name
		outcome.action_name = _action_name
		return outcome


class PointStatePrepareOutcome:
	extends PointStateOutcome

	static func new_prepare_outcome() -> PointStatePrepareOutcome:
		var outcome: PointStatePrepareOutcome = PointStatePrepareOutcome.new()
		outcome.state_name = Point.StateName.PREPARE
		outcome.action_name = Point.ActionName.PREPARE
		return outcome


class PointStatePlayOutcome:
	extends PointStateOutcome

	static func new_play_outcome() -> PointStatePlayOutcome:
		var outcome: PointStatePlayOutcome = PointStatePlayOutcome.new()
		outcome.state_name = Point.StateName.PLAY
		outcome.action_name = Point.ActionName.PLAY
		return outcome


class PointStateEndOutcome:
	extends PointStateOutcome
	var score_home_or_away: Player.HomeOrAway

	static func new_end_outcome(_score_home_or_away: Player.HomeOrAway) -> PointStateEndOutcome:
		var outcome: PointStateEndOutcome = PointStateEndOutcome.new()
		outcome.state_name = Point.StateName.END
		outcome.action_name = Point.ActionName.END
		outcome.score_home_or_away = _score_home_or_away
		return outcome
