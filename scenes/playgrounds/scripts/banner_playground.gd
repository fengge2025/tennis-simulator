extends Node

@onready var banner: Banner = $Banner

func _ready() -> void:
	banner.animation_finished.connect(_on_animation_finished)
	banner.display_banner('miss')

func _on_animation_finished(_animation_name: String):
	banner.display_banner('start')
