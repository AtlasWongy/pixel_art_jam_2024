extends Line2D

@export var max_points: int

func update_trajectory(dir:Vector2, speed: float, delta: float) -> void:
	clear_points()
	var pos: Vector2 = Vector2.ZERO
	var vel = dir * speed
	for i in max_points:
		add_point(pos)
