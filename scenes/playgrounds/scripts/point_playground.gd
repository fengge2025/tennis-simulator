extends Node

@onready var point: Point = $Point
@onready var ball: Ball = $Ball
@onready var player_a: Player = $PlayerA
@onready var player_b: Player = $PlayerB
@onready var banner: Banner = $Banner


func _ready() -> void:
	point.initialize(banner, ball, player_a, player_b)

	point.start_point()
