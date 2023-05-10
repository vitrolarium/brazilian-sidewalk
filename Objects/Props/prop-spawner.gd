extends Node2D

@export_category("Summon Timer")
@export var summon_wait_time : float = 0.5
@export_category("Prop Settings")
@export var props : Array
@export var prop_speed : int = 98

var _summon_timer : Timer

func activate(): _summon_timer.start()

func deactivate(stop_props := false):
	_summon_timer.stop()
	if stop_props:
		for child in get_children():
			if child is Area2D and child.has_method("deactivate"):
				child.deactivate()

func spawn_prop(new_prop : Area2D):
	$SpawnPath/SpawnPoint.progress_ratio = randf()
	new_prop.position = $SpawnPath/SpawnPoint.position
	new_prop.speed = prop_speed
	new_prop.activate()
	add_child(new_prop)

func summon_people():
	if props.is_empty():
		push_error("props is a empty array!")
		return
	var choosen_prop = props.pick_random() as PackedScene
	if choosen_prop:
		var new_prop = choosen_prop.instantiate() as Area2D
		if new_prop:
			spawn_prop(new_prop)
		else:
			push_error("the object ", choosen_prop, "is not a Area2D.")
	else:
		push_error("the prpps array has values that cannot be converted to PackedScene.")

func _ready() -> void:
	_summon_timer = Timer.new()
	_summon_timer.connect("timeout", summon_people)
	_summon_timer.wait_time = summon_wait_time
	add_child(_summon_timer)
	
