extends Node2D

@onready var button: Button = $Button


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	button.pressed.connect(_button_pressed)


func _button_pressed() -> void:
	get_tree().quit()
