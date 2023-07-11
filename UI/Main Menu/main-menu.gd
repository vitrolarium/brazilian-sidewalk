extends Control

@export var main_game : PackedScene

func _ready() -> void:
	%Play.grab_focus()
	%Play.connect("pressed", start_game)
	%Leave.connect("pressed", exit_game)

func start_game() -> void:
	get_tree().change_scene_to_packed(main_game)

func exit_game():
	get_tree().quit()
