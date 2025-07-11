class_name StateMachine extends Node

var states: Array[State]
var prev_state : State
var current_state : State

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_DISABLED

func _process(delta: float) -> void:
	ChangeState(current_state.Process( delta ))
	
func _physiscs_process(delta: float) -> void:
	ChangeState(current_state.Physics( delta ))
	
func _unhandled_input(event: InputEvent) -> void:
	ChangeState(current_state.HandleInput((event)))

func ChangeState(new_state: State) -> void:
	if new_state == null || new_state == current_state:
		return
		
	if current_state:
		current_state.Exit()
		
	prev_state = current_state
	current_state = new_state
	current_state.Enter()
