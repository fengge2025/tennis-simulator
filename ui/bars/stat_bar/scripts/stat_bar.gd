class_name StatBar extends Control

@export var stat_unit: int = 10
@export var texture: Texture2D

@onready var h_box_container: HBoxContainer = $HBoxContainer
@onready var bar_cell_scene = preload("res://ui/bars/stat_bar/bar_cell/bar_cell.tscn")

func update_stat(stat: int):
	for child in h_box_container.get_children():
		child.queue_free()
	
	var cell_count = ceil(float(stat)/stat_unit)
	
	for i in cell_count:
		var bar_cell: BarCell = bar_cell_scene.instantiate()
		bar_cell.texture = texture
		h_box_container.add_child(bar_cell)
	
