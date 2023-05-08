extends Node2D

@export var walking_peoples : Array

func activate(): $SummonTimer.start()

func deactivate(): $SummonTimer.stop()

func summon_people():
	if walking_peoples.is_empty():
		push_error("walking_peoples is a empty array!")
		return
	var choosen_people = walking_peoples.pick_random() as PackedScene
	if choosen_people:
		var new_people = choosen_people.instantiate() as CharacterBody2D
		if new_people:
			$SpawnPath/SpawnPoint.progress_ratio = randf()
			new_people.position = $SpawnPath/SpawnPoint.position
			new_people.enabled = true
			add_child(new_people)
		else:
			push_error("the object ", choosen_people, "is not a CharacterBody2D.")
	else:
		push_error("the walking_peoples array has values that cannot be converted to PackedScene.")
		
