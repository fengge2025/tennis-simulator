class_name State extends Node

@export var state_name: String

var state_machine: StateMachine

func _ready() -> void:
	state_machine = $".."

func enter() -> void:
	pass

func exit() -> void:
	pass
	
func process(_delta: float) -> State:
	return null
	
func physics_process(_delta: float) -> State:
	return null

func handle_input(_event: InputEvent) -> State:
	return null
