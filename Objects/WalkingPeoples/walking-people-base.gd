extends CharacterBody2D

const PLAYER_COLLISION_VALUE = 2
const WALK_DIRECTION := Vector2.DOWN

@export var speed : int = 98
@export var dodge_speed : int = 49
@export var ignore_player : bool = false

var enabled : bool = false

func activate():
	enabled = true
	$AnimationPlayer.play()

func is_player_on_detection(collider_index) -> bool:
	return $ObjectDetection.get_collider(0).get_collision_layer_value(PLAYER_COLLISION_VALUE)

func deactivate():
	enabled = false
	$AnimationPlayer.pause()

func walk_dodge(dodge_direction : float):
	velocity = WALK_DIRECTION * speed
	velocity.x = clampf(dodge_direction, -1, 1) * dodge_speed

func walk():
	velocity = WALK_DIRECTION * speed

func move():
	if $ObjectDetection.is_colliding():
		var dodge_dir = position.x - $ObjectDetection.get_collider(0).position.x
		if (ignore_player and not is_player_on_detection(0)) or (not ignore_player):
			walk_dodge(dodge_dir)
		else:
			walk_dodge(-dodge_dir)
	else:
		walk()
	move_and_slide()


func _physics_process(_delta: float) -> void:
	if enabled:
		move()

func _leave_screen() -> void:
	self.queue_free()
