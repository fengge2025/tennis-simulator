extends Node
class_name TennisMatch


class GameScore:
	var current_match_score: Array[int]
	var current_set_score: Array[int]
	var current_game_score: Array[int]

	func _init() -> void:
		current_match_score = [0, 0]
		current_set_score = [0, 0]
		current_game_score = [0, 0]


class Point:
	var server: TennisPlayer.Player
	var receiver: TennisPlayer.Player


class Game:
	var server: TennisPlayer.Player
	var receiver: TennisPlayer.Player
