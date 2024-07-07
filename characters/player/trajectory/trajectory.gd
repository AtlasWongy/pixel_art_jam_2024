extends Line2D

@export var max_points: int
@export var trajectory_body: CharacterBody2D

func update_trajectory(dir:Vector2, speed: float, delta: float) -> void:
	clear_points()
	var pos: Vector2 = Vector2.ZERO
	var vel = dir * speed
	for i in max_points:
		add_point(pos)
		
		var collision: KinematicCollision2D = trajectory_body.move_and_collide(vel * delta, false, true, true)
		if collision:
			vel = vel.bounce(collision.get_normal())
		
		pos += vel 
		trajectory_body.position = pos
