class_name RacketPlayer extends Node

@onready var player_state_machine: PlayerStateMachine = $PlayerStateMachine
@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	player_state_machine.Initialize(self)


func _process(delta: float) -> void:
	pass


func UpdateAnimation( state: String) -> void:
	animation_player.play(state)
