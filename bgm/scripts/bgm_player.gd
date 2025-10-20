extends Node

@export var bgm_list: Array[AudioStream] = []

var current_index: int = 0

@onready var player: AudioStreamPlayer2D = $AudioStreamPlayer2D


func _ready() -> void:
	if bgm_list.size() > 0:
		_play_bgm(current_index)
		player.connect("finished", _on_player_finished)


func _play_bgm(index: int) -> void:
	if index < 0 or index >= bgm_list.size():
		return

	player.stream = bgm_list[index]
	player.play()


func _on_player_finished() -> void:
	current_index = (current_index + 1) % bgm_list.size()
	_play_bgm(current_index)
