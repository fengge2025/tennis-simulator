class_name GameOutcome extends Outcome

var action_name: Game.ActionName
var state_name: Game.StateName

var score: ScoreBoard.Score

static func action_play_update_score_outcome(_action_name: Game.ActionName, _score: ScoreBoard.Score) -> GameOutcome:
	var outcome: GameOutcome = _action_outcome(_action_name)
	outcome.score = _score
	return outcome

static func _state_outcome(
	_action_name: Game.ActionName, _state_name: Game.StateName
) -> GameOutcome:
	var outcome: GameOutcome = GameOutcome.new()
	outcome.action_name = _action_name
	outcome.state_name = _state_name
	return outcome


static func _action_outcome(_action_name: Game.ActionName) -> GameOutcome:
	var outcome: GameOutcome = GameOutcome.new()
	outcome.action_name = _action_name
	return outcome