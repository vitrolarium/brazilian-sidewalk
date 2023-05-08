extends CharacterBody2D

const PLAYER_COLLISION_LAYER = 2
const WALK_DIRECTION := Vector2.DOWN

@export var speed : int = 98
@export var ignore_player : bool = false

var enabled : bool = false

func activate():
	enabled = true
	$AnimationPlayer.play()

func deactivate():
	enabled = false
	$AnimationPlayer.pause()

func walk_dodge(dodge_direction : Vector2):
	velocity = (WALK_DIRECTION + dodge_direction).normalized() * speed

func walk():
	velocity = WALK_DIRECTION * speed

func move():
	if $ObjectDetection.is_colliding():
		if ignore_player:
			for i in $ObjectDetection.get_collision_count():
				var col = $ObjectDetection.get_collider(i) as CollisionObject2D
				if col and not col.get_collision_layer_value(PLAYER_COLLISION_LAYER):
					walk_dodge(Vector2.LEFT)
					break
		else:
			walk_dodge(Vector2.RIGHT)
	else:
		walk()
	move_and_slide()


func _physics_process(_delta: float) -> void:
	if enabled:
		move()

func leave_screen() -> void:
	self.queue_free()
