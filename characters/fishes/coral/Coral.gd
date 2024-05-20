extends FishResource
class_name Coral

var ray_cast_arrays: Array[RayCast2D] = []
var fish_array = []
var fish_body: Node2D

func fish_init(body):
	fish_body = body
	fish_body.add_to_group("coral")
	#for obj in fish_body.get_tree().get_nodes_in_group("Fish"):
		#if (obj.position.y <= fish_body.position.y+100 && obj.position.y >= fish_body.position.y-100 && obj.position.x <= fish_body.position.x+100 && obj.position.x >= fish_body.position.x-100):
			#obj.fish_resource.has_shield = true
	for i in range(4):
		match(i):
			0:
				ray_cast_arrays.append(generate_raycasts(Vector2(64, 0)))
			1:
				ray_cast_arrays.append(generate_raycasts(Vector2(0, 64)))
			2:
				ray_cast_arrays.append(generate_raycasts(Vector2(-64, 0)))
			3:
				ray_cast_arrays.append(generate_raycasts(Vector2(0, -64)))
	
func fish_physics():
	provide_shield()
	#pass

func on_collision(body):
	for raycast in ray_cast_arrays:
		if is_instance_valid(raycast):
			raycast.call_deferred("queue_free")

func provide_shield():
	for raycast in ray_cast_arrays:
		if is_instance_valid(raycast):
			if raycast.is_colliding():
				if raycast.get_collider() != null:
					var collision = raycast.get_collider().get_parent()
					if collision.has_method("add_shield"):
						collision.add_shield()

func generate_raycasts(target_dir: Vector2) -> RayCast2D:
	var raycast = RayCast2D.new()
	fish_body.add_child(raycast)
	raycast.enabled = true
	raycast.exclude_parent = true
	raycast.collide_with_areas = true
	raycast.set_collision_mask_value(4, true)
	raycast.set_collision_mask_value(1, false)
	raycast.position = Vector2(0, 0)
	raycast.target_position = target_dir
	return raycast

#func free_raycast(raycast):
	#if is_instance_valid(raycast):
		#raycast.queue_free()

