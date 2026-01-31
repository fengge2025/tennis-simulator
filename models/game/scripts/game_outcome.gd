class_name GameOutcome extends Outcome

var action_name: Game.ActionName
var state_name: Game.StateName
var game_winner: Player.HomeOrAway

static func action_end_outcome(_action_name: Game.ActionName, _game_winner: Player.HomeOrAway) -> GameOutcome:
	var outcome: GameOutcome = _action_outcome(_action_name)
	outcome.game_winner = _game_winner
	return outcome

static func state_play_outcome(_action_name: Game.ActionName, _state_name: Game.StateName, _game_winner: Player.HomeOrAway) -> GameOutcome:
	var outcome: GameOutcome = _state_outcome(_action_name, _state_name)
	outcome.game_winner = _game_winner
	return outcome

static func state_end_outcome(_action_name: Game.ActionName, _state_name: Game.StateName) -> GameOutcome:
	return _state_outcome(_action_name, _state_name)

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
