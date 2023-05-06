extends CharacterBody2D

@export var speed : int = 98

func _physics_process(delta: float) -> void:
	velocity = Vector2(Input.get_axis("move_left", "move_right"), Input.get_axis("move_up", "move_down")).normalized() * speed
	move_and_slide()
