extends FishResource 
class_name Pufferfish

func fish_init(fish:Fish):
	print(fish.position)

func on_collision_with_all_param(body,fish:Fish,fish_resource:FishResource):
	if body is Bubble and fish is Fish:
		SignalBus.shot_completed.emit()
		if !fish.fish_resource.has_shield:
			await play_animation(fish)
			death_tween_function(fish,fish_resource)
	#if body is Fish:
		#clear_surrounding_fish(body)
	

func play_animation(fish:Fish):
	var tween = fish.create_tween()
	tween.parallel().tween_property(fish, "scale", Vector2(4,4), 1)
	# Tween for the collision shape scaling
	#var collision_shape = fish.get_node("Area2D/CollisionShape2D")
	#var shape = collision_shape.shape
	#if shape is RectangleShape2D:
		#shape.set_size(Vector2(64, 64))
		#tween.parallel().tween_property(shape, "size", Vector2(50,50), 1)

	await tween.finished

	var objects_to_free = []
	for obj in fish.get_tree().get_nodes_in_group("Fish"):
		#print(obj.position.y <= fish.position.y+100 && obj.position.y >= fish.position.y-100 && obj.position.x <= fish.position.x+100 && obj.position.x >= fish.position.x-100)
		#print(obj.position.y <= fish.position.y+100)
		#print(obj.position.y >= fish.position.y-100)
		#print(obj.position.x <= fish.position.x+100)
		#print(obj.position.x >= fish.position.x-100)
		if (obj.position.y <= fish.position.y+100 && obj.position.y >= fish.position.y-100 && obj.position.x <= fish.position.x+100 && obj.position.x >= fish.position.x-100):
			print("Object has shield", obj.fish_resource.has_shield)
			if obj.fish_resource.has_shield:
				obj.fish_resource.has_shield = false
			elif !obj.fish_resource.has_shield:
				objects_to_free.append(obj)

	# Queue the _free method for each object in objects_to_free
	for obj_to_free in objects_to_free:
		obj_to_free.queue_free()

#func clear_surrounding_fish(body):
	#if body is Fish:
		#body.queue_free()
	#print("pufferfish should clear fish")
	
func death_tween_function(fish:Fish, fish_resource:FishResource):
	var death_tween = fish.create_tween()
	death_tween.tween_method(func(value):
			set_shader_value(fish_resource, value),1.0,0.0,0.25)
	fish.queue_free()
	SignalBus.fish_destroyed.emit(fish_resource.fish_value)

func set_shader_value(fish_resource:FishResource, value:float):
	var sprite = fish_resource.get_node_or_null(Sprite2D, fish_resource.sprite_node_path)
	sprite.material.set_shader_parameter("dissolve_value",value)

