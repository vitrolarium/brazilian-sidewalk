extends CharacterBody2D

const WALK_DIRECTION := Vector2.DOWN

@export var speed : int = 98

var enabled : bool = false

func activate():
	enabled = true
	$AnimationPlayer.play()

func deactivate():
	enabled = false
	$AnimationPlayer.pause()

func _physics_process(_delta: float) -> void:
	if enabled:
		move()

func move():
	if $ObjectDetection.is_colliding():
		velocity = (WALK_DIRECTION + Vector2.RIGHT).normalized() * speed
	else:
		velocity = WALK_DIRECTION * speed
	move_and_slide()
