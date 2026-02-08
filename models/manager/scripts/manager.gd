class_name Manager extends Node2D

enum ActionName { IDLE }
enum StateName { IDLE }

var logger: Logger = Logger.initialize("manager")

var current_action: ActionName = ActionName.IDLE

var score: Score

@onready var banner: Banner = $Banner
@onready var player_home: Player = $PlayerHome
@onready var player_away: Player = $PlayerAway
@onready var ball: Ball = $Ball
@onready var point: Point = $Point
@onready var score_board: ScoreBoard = $ScoreBoard
@onready var state_machine: ManagerStateMachine = $ManagerStateMachine


func initialize() -> void:
	state_machine.initialize(self)
	score = Score.new()
	point.initialize(banner, ball, player_home, player_away)
	point.action_finished.connect(_point_action_finished)


func start_point_action() -> void:
	point.start_point_action()


func _point_action_finished(action_outcome: PointOutcome.PointActionOutcome) -> void:
	match action_outcome.action_name:
		Point.ActionName.END:
			var end_game: bool = score.update_point(action_outcome.score_home_or_away)
			if end_game:
				print("Game Over! Winner:", action_outcome.score_home_or_away)
				score.clean_point()
				var end_set: bool = score.update_game(action_outcome.score_home_or_away)
				if end_set:
					print("Set Over! Winner:", action_outcome.score_home_or_away)
					score.clean_game()
					var end_match: bool = score.update_set(action_outcome.score_home_or_away)
					if end_match:
						score.clean_set()
						print("Match Over! Winner:", action_outcome.score_home_or_away)

			score_board.update_score_board(score)
			point.start_point_action()
		_:
			pass


func _ready() -> void:
	pass
