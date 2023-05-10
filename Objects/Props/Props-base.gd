extends Area2D

const MOVE_DIRECTION := Vector2.DOWN

enum PropType {
	OBSTACLE,
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

func on_body_entered(body: Node2D) -> void:
	if body.has_method("prop_collided"):
		body.call("prop_collided", self)

func _process(delta: float) -> void:
	if enabled:
		position += MOVE_DIRECTION * speed * delta
