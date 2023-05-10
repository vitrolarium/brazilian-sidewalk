extends Node2D

var is_game_over = false

func start_game():
	print("game started")
	$SidewalkManager.is_enabled = true
	$WalkingPeopleSpawner.activate()
	$PropSpawner.activate()
	$Player.reset()
	$Player.show()

func stop_game(reason : String):
	if $Player.has_method(reason):
		$Player.call(reason)
	else:
		push_warning(reason, "() method doesnt exists in player")

func _ready() -> void:
	start_game()

func _on_player_game_over() -> void:
	$SidewalkManager.is_enabled = false
	$PropSpawner.deactivate(true)
	#$WalkingPeopleSpawner.deactivate(true)
	is_game_over = true

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("reset"):
		start_game()
