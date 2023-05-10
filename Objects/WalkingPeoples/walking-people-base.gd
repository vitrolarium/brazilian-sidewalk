extends CharacterBody2D

const PLAYER_COLLISION_VALUE = 2
const WALK_DIRECTION := Vector2.DOWN
const NORMAL_SPEED_SCALE = 1
const NORMAL_COLOR = Color(1, 1, 1)
const STRESSED_SPEED_SCALE = 2
const STRESSED_COLOR = Color(0.73, 0.62, 0.62)

@export var speed : int = 98
@export var dodge_speed : int = 49
@export var is_stressed : bool = false

var _enabled : bool = false

func activate():
	_enabled = true
	$AnimationPlayer.speed_scale = NORMAL_SPEED_SCALE if not is_stressed else STRESSED_SPEED_SCALE
	modulate = NORMAL_COLOR if not is_stressed else STRESSED_COLOR
	$AnimationPlayer.play("walking")

func deactivate():
	_enabled = false
	$AnimationPlayer.pause()

func is_player_on_detection(collider_index) -> bool:
	var col = $ObjectDetection.get_collider(collider_index) as CollisionObject2D
	return col and col.get_collision_layer_value(PLAYER_COLLISION_VALUE)

func walk_dodge(dodge_direction : float):
	velocity = WALK_DIRECTION * speed
	velocity.x = clampf(dodge_direction, -1, 1) * dodge_speed

func walk():
	velocity = WALK_DIRECTION * speed

func move():
	if $ObjectDetection.is_colliding():
		var dodge_dir = position.x - $ObjectDetection.get_collider(0).position.x
		if (is_stressed and not is_player_on_detection(0)) or (not is_stressed):
			walk_dodge(dodge_dir)
		else:
			walk_dodge(-dodge_dir)
	else:
		walk()
	move_and_slide()


func _physics_process(_delta: float) -> void:
	if _enabled:
		move()

func _leave_screen() -> void:
	self.queue_free()
