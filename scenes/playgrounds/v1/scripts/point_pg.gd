extends Node

@onready var player_home: Player = $PlayerHome
@onready var player_away: Player = $PlayerAway
@onready var ball: Ball = $Ball
@onready var point: Point = $Point
@onready var banner: Banner = $Banner


func _ready() -> void:
	point.initialize(banner, ball, player_home, player_away)

	point.start_point_action()
