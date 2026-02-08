class_name BarCell extends Control

var texture: Texture2D:
	set(value):
		if is_inside_tree():
			texture_rect.texture = value

@onready var texture_rect: TextureRect = $TextureRect
