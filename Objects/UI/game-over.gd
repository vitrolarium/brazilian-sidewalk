extends Control

func _on_button_pressed() -> void:
	get_tree().reload_current_scene()

func _on_button_2_pressed() -> void:
	get_tree().change_scene_to_file("res://Objects/UI/main-menu.tscn")
