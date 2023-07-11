extends Node2D

@export_category("Sidewalk Settings")
@export var sidewalk_speed : int
@export var alt_sidewalk_chance : float

@export_category("Sidewalk Objects")
@export var main_sidewalk : PackedScene
@export var alt_sidewalk : Array

var current_sidewalks : Array
var _viewport_size : Vector2
var is_enabled : bool = false

func _ready() -> void:
	_viewport_size = get_viewport_rect().size
	for i in range(3):
		var new_sidewalk = main_sidewalk.instantiate() as TileMap
		assert(new_sidewalk, "variable 'main_sidewalk' is not of the type 'TileMap'.")
		new_sidewalk.position.y -= i * _viewport_size.y
		current_sidewalks.push_back(new_sidewalk)
		add_child(new_sidewalk)

func _physics_process(delta: float) -> void:
	if is_enabled:
		move_sidewalks(sidewalk_speed * delta)

func move_sidewalks(speed : float):
	for sidewalk in current_sidewalks:
		sidewalk.position.y += speed
		
		if sidewalk.position.y > _viewport_size.y:
			if randf() < alt_sidewalk_chance:
				var new_sidewalk = alt_sidewalk.pick_random().instantiate() as TileMap
				new_sidewalk.position.y = sidewalk.position.y - _viewport_size.y * 3
				current_sidewalks.push_back(new_sidewalk)
				add_child(new_sidewalk)
				
				current_sidewalks.erase(sidewalk)
				sidewalk.queue_free()
			else:
				var new_sidewalk = main_sidewalk.instantiate() as TileMap
				new_sidewalk.position.y = sidewalk.position.y - _viewport_size.y * 3
				current_sidewalks.push_back(new_sidewalk)
				add_child(new_sidewalk)
				
				current_sidewalks.erase(sidewalk)
				sidewalk.queue_free()
