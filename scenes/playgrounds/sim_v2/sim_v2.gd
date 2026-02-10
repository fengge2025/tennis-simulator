extends Node2D

@onready var sim_section_manager: SimSectionManager = $PanelContainer/GridContainer/SimSectionManager
@onready
var sim_section_manager_2: SimSectionManager = $PanelContainer/GridContainer/SimSectionManager2
@onready
var sim_section_manager_3: SimSectionManager = $PanelContainer/GridContainer/SimSectionManager3
@onready
var sim_section_manager_4: SimSectionManager = $PanelContainer/GridContainer/SimSectionManager4


func _ready() -> void:
	sim_section_manager.initialize(1000, 10, 10)
	sim_section_manager.start_sim()

	sim_section_manager_2.initialize(1000, 11, 10)
	sim_section_manager_2.start_sim()

	sim_section_manager_3.initialize(1000, 12, 10)
	sim_section_manager_3.start_sim()

	sim_section_manager_4.initialize(1000, 13, 10)
	sim_section_manager_4.start_sim()
