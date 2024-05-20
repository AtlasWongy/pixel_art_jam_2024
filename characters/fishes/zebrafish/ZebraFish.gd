extends FishResource
class_name ZebraFish

var adjacent_ray_cast_arrays: Array[RayCast2D] = []
var forward_ray_cast_arrays: Array[RayCast2D] = []

#var move_foward_flag = true
#var no_fish_infront_flag = false

var fish_body: Node2D
var signals_connected: bool = false
var starting_flag: bool = true

func fish_init(body):
	#if fish_body is Fish:
		#for obj in fish_body.get_tree().get_nodes_in_group("Fish"):
			#if (obj.position.x <= fish_body.position.x+64 
			#and obj.position.x >= fish_body.position.x-64
			#and !(obj.fish_resource is ZebraFish)):
				#adjacent_fishes.append(obj)
	#print("zebra adjacent: ", adjacent_fishes.size())
	fish_body = body
	starting_flag = true
	set_ray_cast()
	detect_adjacent_fishes(fish_body)
	print("zebra adjacent: ", fish_body.fish_resource.move_foward_flag)
	print("zebra in front: ", fish_body.fish_resource.no_fish_infront_flag)
	# Ensure signals are connected only once
	#if not signals_connected:
		#SignalBus.shot_completed.connect(detect_adjacent_fishes)
		##SignalBus.start_shot.connect(detect_adjacent_fishes)
		#signals_connected = true
	
#func fish_physics():
	#if is_instance_valid(fish_body):
		#detect_adjacent_fishes()
		
func set_ray_cast():
	for i in range(3):
		match(i):
			0:
				adjacent_ray_cast_arrays.append(generate_raycasts(Vector2(64, 0)))
			1:
				forward_ray_cast_arrays.append(generate_raycasts(Vector2(0, 64)))
			2:
				adjacent_ray_cast_arrays.append(generate_raycasts(Vector2(-64, 0)))
			#3:
				#ray_cast_arrays.append(generate_raycasts(Vector2(0, -64)))
				
#func on_collision_with_body_param(body, fish):
	##print("zebrafish!")
	#if fish_body == fish:
		#if is_instance_valid(fish_body) and is_instance_valid(fish_body.fish_resource):
			#if !fish_body.fish_resource.has_shield:
				#if body is Bubble:
					#clear_rays()
				#elif body is Fish:
					#if fish_body.fish_resource is Pufferfish:
						#clear_rays()

func detect_adjacent_fishes(fish:Fish):
	#print("zebra")
	fish_body = fish
	if is_instance_valid(fish_body):	
		fish_body.fish_resource.move_foward_flag = false
		fish_body.fish_resource.no_fish_infront_flag = false
		set_ray_cast()
	for raycast in adjacent_ray_cast_arrays:
		if is_instance_valid(raycast):
			if raycast.is_colliding():
				if raycast.get_collider() != null:
					var collision = raycast.get_collider().get_parent()
					print("zebra collided: ", collision.get_class())
					if collision is Fish:
						print("zebra collided fish")
						fish_body.fish_resource.move_foward_flag = true
						break
						
	for raycast in forward_ray_cast_arrays:
		if is_instance_valid(raycast):
			if raycast.is_colliding():
				if raycast.get_collider() != null:
					var collision = raycast.get_collider().get_parent()
					if collision is Fish:
						fish_body.fish_resource.no_fish_infront_flag = true
						
	if is_instance_valid(fish_body) && starting_flag:	
		starting_flag = false
		print("zebra adjacent: ", fish_body.fish_resource.move_foward_flag)
		print("zebra in front: ", fish_body.fish_resource.no_fish_infront_flag)
		if (fish_body.fish_resource.move_foward_flag && !fish_body.fish_resource.no_fish_infront_flag):
			move_foward()

	
func move_foward():
	print("zebra move one more step foward")
	var tween = fish_body.get_tree().create_tween()
	tween.tween_property(fish_body,"position",fish_body.position+Vector2(0,64),0.5).set_trans(Tween.TRANS_SINE)

func generate_raycasts(target_dir: Vector2) -> RayCast2D:
	var raycast = RayCast2D.new()
	fish_body.add_child(raycast) 
	raycast.enabled = true
	raycast.exclude_parent = true
	raycast.collide_with_areas = true
	#raycast.set_collision_mask_value(4, true)
	raycast.set_collision_mask_value(1, true)
	raycast.position = Vector2(0, 0)
	raycast.target_position = target_dir
	return raycast

func clear_rays():
	if is_instance_valid(fish_body.fish_resource):
		for raycast in adjacent_ray_cast_arrays:
			if is_instance_valid(raycast):
				raycast.call_deferred("queue_free")
		for raycast in forward_ray_cast_arrays:
			if is_instance_valid(raycast):
				raycast.call_deferred("queue_free")

