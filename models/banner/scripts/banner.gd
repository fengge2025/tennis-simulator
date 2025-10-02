class_name Banner extends Node2D

signal animation_finished()

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var timer: Timer = $Timer

func _ready() -> void:
	timer.timeout.connect(_on_timeout)
	
func display_banner(animation: String, display_during: float = 2.0) -> void:
	update_animation(animation)
	timer.start(display_during)

func update_animation(animation: String) -> void:
	animation_player.play(animation)
	
func _on_timeout() -> void:
	update_animation('RESET')
	animation_finished.emit()
