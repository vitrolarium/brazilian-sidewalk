extends Node2D

var is_game_over = false
var score : int = 0

func start_game():
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
	$death_timer.start()
	$score_timer.stop()


func _on_death_timer_timeout() -> void:
	$GameOver.show()


func _on_score_timer_timeout() -> void:
	score += 1
	$hud.set_score(score)
