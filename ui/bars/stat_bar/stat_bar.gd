class_name StatBar extends Control

@export var cell_unit: int
@export var texture: Texture2D:
	set(value):
		texture = value
		if is_inside_tree():
			for i in range(bar_cells.size()):
				bar_cells[i].texture = value

var bar_cells: Array[BarCell]

@onready var h_box_container: HBoxContainer = $HBoxContainer


func _ready() -> void:
	for bar_cell in h_box_container.get_children():
		bar_cells.append(bar_cell)
		bar_cell.texture = texture


func update_stat(stat: int) -> void:
	var cell_count: int = ceil(float(stat) / float(cell_unit))
	for i in range(bar_cells.size()):
		bar_cells[i].visible = i < cell_count
