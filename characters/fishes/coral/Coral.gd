extends FishResource
class_name Coral

var ray_cast_arrays: Array[RayCast2D] = []
var fish_body: Node2D

func fish_init(body):
	fish_body = body
	var raycast = RayCast2D.new()
	fish_body.add_child(raycast)
	raycast.enabled = true
	raycast.exclude_parent = true
	raycast.collide_with_areas = true
	raycast.set_collision_mask_value(4, true)
	raycast.set_collision_mask_value(1, false)
	raycast.position = Vector2(0,0)
	raycast.target_position = Vector2(600, 0)
	ray_cast_arrays.append(raycast)
	
func fish_physics():
	provide_shield()

func provide_shield():
	for raycast in ray_cast_arrays:
		if raycast.is_colliding():
			var collision = raycast.get_collider().get_parent()
			if collision.has_method("add_shield"):
				collision.add_shield()
