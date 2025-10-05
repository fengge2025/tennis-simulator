class_name Banner extends Node2D

signal animation_finished(animation_name: String)

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var timer: Timer = $Timer

var animation_name: String = ''

func _ready() -> void:
	timer.timeout.connect(_on_timeout)
	
func display_banner(_animation_name: String, display_during: float = 2.0) -> void:
	animation_name = _animation_name
	update_animation(_animation_name)
	timer.start(display_during)

func update_animation(animation_name: String) -> void:
	animation_player.play(animation_name)
	
func _on_timeout() -> void:
	update_animation('RESET')
	animation_finished.emit(animation_name)
