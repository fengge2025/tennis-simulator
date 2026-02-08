class_name BarCell extends Control

var texture: Texture2D:
	set(value):
		if is_inside_tree():
			texture_rect.texture = value 

@onready var texture_rect: TextureRect = $TextureRect

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
