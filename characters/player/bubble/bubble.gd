extends RigidBody2D

@export_category("Bubble Speed")
@export var initial_bubble_speed: float = 20
@export var increment_bubble_speed: float = 1.02

var player_rotation: float
var direction: Vector2

func _physics_process(delta):
	checking_exceed_boundary()
	var collision: KinematicCollision2D = move_and_collide(linear_velocity * initial_bubble_speed * delta)
	if collision:
		linear_velocity = linear_velocity.bounce(collision.get_normal())

func fire_bubble():
	direction = Vector2(-1, 0).rotated(player_rotation)
	linear_velocity = direction.normalized() * initial_bubble_speed

func checking_exceed_boundary():
	if (position.x <= -get_viewport_rect().size.x
		or position.y > get_viewport_rect().size.y
		or position.y < -get_viewport_rect().size.y):
		queue_free()
		SignalBus.bubble_finished.emit()
