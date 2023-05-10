extends CharacterBody2D

const _SPRITE_SIZE = Vector2(14, 14)
const _WALKING_AREA = Rect2(0, 0, 112, 192)
const _CLAMPPED_AREA = Rect2(
	_WALKING_AREA.position + Vector2(0 + _SPRITE_SIZE.x / 2, _SPRITE_SIZE.y), 
	_WALKING_AREA.end - Vector2(_SPRITE_SIZE.x, _SPRITE_SIZE.y))

signal game_over

@export var speed : int = 98

var is_dead = false

func shock():
	$AnimationPlayer.play("shock")
	is_dead = true
	emit_signal("game_over")

func fall():
	$AnimationPlayer.play("fall")
	is_dead = true
	emit_signal("game_over")

func hit_the_ground():
	$AnimationPlayer.play("dead")
	is_dead = true
	emit_signal("game_over")

func reset():
	print("player reset")
	$AnimationPlayer.play("RESET")
	$AnimationPlayer.advance(0)
	$AnimationPlayer.play("walking")
	is_dead = false

func prop_collided(prop : Area2D):
	if prop.prop_type == prop.PropType.HOLE:
		fall()
	elif prop.prop_type == prop.PropType.OBSTACLE:
		hit_the_ground()
	elif prop.prop_type == prop.PropType.ELETRICITY:
		shock()

func _physics_process(_delta: float) -> void:
	var direction = Vector2(
		Input.get_axis("move_left", "move_right"), 
		Input.get_axis("move_up", "move_down"))
	
	if not is_dead:
		velocity = direction.normalized() * speed
		move_and_slide()
		position = position.clamp(_CLAMPPED_AREA.position, _CLAMPPED_AREA.end)
