extends Control

@export var exit_scene : String = "res://UI/Main Menu/main-menu.tscn"

func _on_button_pressed() -> void:
	get_tree().reload_current_scene()

func _on_button_2_pressed() -> void:
	get_tree().change_scene_to_file(exit_scene)
