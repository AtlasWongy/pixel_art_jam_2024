extends FishResource
class_name Rockfish

func on_collision(body):
	print("rockfish!")
	print(body)
	var random_vector = Vector2(0,-1).normalized()
	body.linear_velocity = body.linear_velocity.bounce(random_vector) * body.speed_multiplier
