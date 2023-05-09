extends Node2D

enum PeopleType {NORMAL, STRESSED}

@export var walking_peoples : Array
@export var normal_people_speed : int = 98
@export var stressed_people_speed : int = 148
@export var stressed_people_chance : float = 0.2

func activate(): $SummonTimer.start()

func deactivate(stop_peoples := false):
	$SummonTimer.stop()
	if stop_peoples:
		for child in get_children():
			if child is CharacterBody2D and child.has_method("deactivate"):
				child.deactivate()

func spawn_people(new_people : CharacterBody2D, people_type : PeopleType):
	$SpawnPath/SpawnPoint.progress_ratio = randf()
	new_people.position = $SpawnPath/SpawnPoint.position
	new_people.speed = normal_people_speed if people_type == PeopleType.NORMAL else stressed_people_speed
	new_people.is_stressed = people_type == PeopleType.STRESSED
	new_people.activate()
	add_child(new_people)

func summon_people():
	if walking_peoples.is_empty():
		push_error("walking_peoples is a empty array!")
		return
	var choosen_people = walking_peoples.pick_random() as PackedScene
	if choosen_people:
		var new_people = choosen_people.instantiate() as CharacterBody2D
		if new_people:
			if randf() < stressed_people_chance:
				spawn_people(new_people, PeopleType.STRESSED)
			else:
				spawn_people(new_people, PeopleType.NORMAL)
		else:
			push_error("the object ", choosen_people, "is not a CharacterBody2D.")
	else:
		push_error("the walking_peoples array has values that cannot be converted to PackedScene.")
		
