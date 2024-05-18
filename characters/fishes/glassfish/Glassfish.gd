extends FishResource 
class_name Glassfish

func on_collision(body):
	print("glassfish!")
	var random_vector = Vector2(randf_range(0, 1), randf_range(0, 1)).normalized()
	print(random_vector)
	body.linear_velocity = body.linear_velocity.bounce(random_vector) * body.speed_multiplier
