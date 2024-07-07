extends Fish
class_name JellyFish

func trigger_death_skill(body: Node2D) -> void:
	var random_vector: Vector2 = Vector2(randf_range(0, 1), randf_range(0, 1)).normalized()
	body.linear_velocity = body.linear_velocity.bounce(random_vector)
