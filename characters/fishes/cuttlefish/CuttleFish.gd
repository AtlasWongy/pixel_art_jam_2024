extends FishResource
class_name CuttleFish

var ray_cast_arrays: Array[RayCast2D] = []
var fish_body: Node2D

# Called when the node enters the scene tree for the first time.
func fish_init(body):
	fish_body = body
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

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func provide_camoufladge():
	for raycast in ray_cast_arrays:
		if raycast.is_colliding():
			var collision = raycast.get_collider().get_parent()
			if collision.has_method("activate_camoufladge"):
				print("You cannot see me now")

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
