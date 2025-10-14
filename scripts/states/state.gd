class_name State extends Node

var state_name: String

var state_machine: StateMachine
var state_processing = false

func _ready() -> void:
	state_machine = $".."

func enter() -> void:
	state_processing = true

func exit() -> void:
	state_processing = false
	
func process(_delta: float) -> State:
	return null
	
func physics_process(_delta: float) -> State:
	return null

func handle_input(_event: InputEvent) -> State:
	return null
