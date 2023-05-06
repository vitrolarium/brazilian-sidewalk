extends CharacterBody2D

const _SPRITE_SIZE = Vector2(14, 14)
const _WALKING_AREA = Rect2(0, 0, 112, 192)
const _CLAMPPED_AREA = Rect2(
	_WALKING_AREA.position + Vector2(0 + _SPRITE_SIZE.x / 2, _SPRITE_SIZE.y), 
	_WALKING_AREA.end - Vector2(_SPRITE_SIZE.x, _SPRITE_SIZE.y))

@export var speed : int = 98

var is_dead = false

func _physics_process(_delta: float) -> void:
	var direction = Vector2(
		Input.get_axis("move_left", "move_right"), 
		Input.get_axis("move_up", "move_down"))
	
	if not is_dead:
		velocity = direction.normalized() * speed
		move_and_slide()
		position = position.clamp(_CLAMPPED_AREA.position, _CLAMPPED_AREA.end)

func shock():
	$AnimationPlayer.play("shock")
	is_dead = true

func fall():
	$AnimationPlayer.play("dead")
	is_dead = true

func reset():
	$AnimationPlayer.play("walking")
	is_dead = false
