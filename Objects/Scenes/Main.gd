extends Node2D

var game_is_running = true

func _ready() -> void:
	$SidewalkManager.is_enabled = true


func _on_die_pressed() -> void:
	if game_is_running:
		$SidewalkManager.is_enabled = false
		game_is_running = false
		$Player.fall()
	else:
		game_is_running = true
		$SidewalkManager.is_enabled = true
		$Player.reset()


func _on_shock_pressed() -> void:
	if game_is_running:
		$SidewalkManager.is_enabled = false
		game_is_running = false
		$Player.shock()
	else:
		game_is_running = true
		$SidewalkManager.is_enabled = true
		$Player.reset()
