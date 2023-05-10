extends Area2D

const MOVE_DIRECTION := Vector2.DOWN

enum PropType {
	HOLE,
	ELETRICITY
}

@export var speed : int = 98
@export var prop_type : PropType

var enabled = false


func activate():
	enabled = true

func deactivate():
	enabled = false

func screen_leave() -> void:
	queue_free()

func _process(delta: float) -> void:
	if enabled:
		position += MOVE_DIRECTION * speed * delta
