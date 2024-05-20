extends FishResource 
class_name Pufferfish

var exploded = false

func fish_init(fish:Fish):
	print(fish.position)

func on_collision_with_body_param(body,fish:Fish):
	if !fish.fish_resource.has_shield:
		if body is Bubble and fish.fish_resource is Pufferfish:
			exploded = true
			SignalBus.shot_completed.emit()
			#if !fish.fish_resource.has_shield:
			var collision_shape = fish.get_node("Area2D")
			# Connect the body_entered signal to a function
			await play_animation(fish)
		death_tween_function(fish)
	#if body is Fish:
		#clear_surrounding_fish(body)

func get_explosion_flag() -> bool:
	return exploded

func play_animation(fish:Fish):
	var tween = fish.create_tween()
	var sprite = fish.get_node("Sprite2D")

	# Animate the scale using the tween
	tween.tween_property(sprite, "scale", Vector2(6,6), 1)
	#tween.parallel().tween_property(sprite, "scale", Vector2(4,4), 1)
	# Tween for the collision shape scaling
	#var collision_shape = fish.get_node("Area2D/CollisionShape2D")
	#var shape = collision_shape.shape
	#if shape is RectangleShape2D:
		#shape.set_size(Vector2(64, 64))
		#tween.parallel().tween_property(shape, "size", Vector2(50,50), 1)
	# Tween for the collision shape scaling
	var collision_shape = fish.get_node("Area2D")
	#var shape = collision_shape.shape
		
	tween.parallel().tween_property(collision_shape, "scale", Vector2(6,6), 1)

	#var collision_shape = fish.get_node("Area2D/CollisionShape2D")
	#var shape = collision_shape.shape
	#if shape is RectangleShape2D:
		#tween.parallel().tween_property(shape, "extents", shape.extents * 4, 1)
	await tween.finished

	#var objects_to_free = []
	#for obj in fish.get_tree().get_nodes_in_group("Fish"):
		#if (obj.position.y <= fish.position.y+100 && obj.position.y >= fish.position.y-100 && obj.position.x <= fish.position.x+100 && obj.position.x >= fish.position.x-100):
			#print("Object has shield", obj.fish_resource.has_shield)
			#if obj.fish_resource.has_shield:
				#obj.fish_resource.has_shield = false
			#elif !obj.fish_resource.has_shield:
				#objects_to_free.append(obj)

	# Queue the _free method for each object in objects_to_free
	#for obj_to_free in objects_to_free:
		#obj_to_free.queue_free()

#func clear_surrounding_fish(body):
	#if body is Fish:
		#body.queue_free()
	#print("pufferfish should clear fish")
	
func death_tween_function(fish:Fish):
	var death_tween = fish.create_tween()
	death_tween.tween_method(func(value):
			set_shader_value(fish, value),1.0,0.0,0.25)
	fish.queue_free()
	SignalBus.fish_destroyed.emit(fish.fish_resource.fish_value)

func set_shader_value(fish:Fish, value:float):
	var sprite = fish.get_node("Sprite2D")
	sprite.material.set_shader_parameter("dissolve_value",value)
