extends Node2D


func start_game():
	$SidewalkManager.is_enabled = true
	$WalkingPeopleSpawner.activate()
	$Player.show()

func stop_game(reason : String):
	if $Player.has_method(reason):
		$Player.call(reason)
	else:
		push_warning(reason, "() method doesnt exists in player")
	
	$SidewalkManager.is_enabled = false
	$WalkingPeopleSpawner.deactivate(true)


func _ready() -> void:
	start_game()

func _on_die_pressed() -> void:
	stop_game("fall")

func _on_shock_pressed() -> void:
	stop_game("shock")
