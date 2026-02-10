class_name StatBar extends Control

enum Orientation { VERTICAL, HORIZONTAL }

@export var cell_unit: int
@export var texture: Texture2D:
	set(value):
		texture = value
		if is_inside_tree():
			for i in range(bar_cells.size()):
				bar_cells[i].texture = value
@export var orientation: Orientation:
	set(value):
		if orientation == Orientation.VERTICAL:
			h_box_container.rotation_degrees = -90
			h_box_container.position = Vector2(0, 160)
@export var ascale: Vector2:
	set(value):
		scale = value

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
