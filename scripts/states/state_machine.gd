class_name StateMachine extends Node

var states: Dictionary
var prev_state : State
var current_state : State

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_DISABLED

func _process(delta: float) -> void:
	change_state(current_state.process( delta ))
	
func _physics_process(delta: float) -> void:
	change_state(current_state.physics_process( delta ))
	
func _unhandled_input(event: InputEvent) -> void:
	change_state(current_state.handle_input((event)))

func change_state(new_state: State) -> void:
	if new_state == null || new_state == current_state:
		return
		
	if current_state:
		current_state.exit()
		
	prev_state = current_state
	current_state = new_state
	current_state.enter()

func change_to(state_name: String) -> void:
	var state = states[state_name]
	change_state(state)
