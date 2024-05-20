extends FishResource
class_name Swordfish

func fish_init(fish:Fish):
	print(fish.position)

func on_collision_with_body_param(body,fish:Fish):
	if body is Bubble:
		print(body.position)
		#size of the bubble is 18x18 px
		print(fish.position)
		#size of the fish is 32x32 px
		if(abs(body.position.x-fish.position.x) > 20 or (fish.position.y-body.position.y)> 20):
			pass
		else:
			SignalBus.shot_completed.emit()
			death_tween_function(fish)

func death_tween_function(fish:Fish):
	var death_tween = fish.create_tween()
	death_tween.tween_method(func(value):
			set_shader_value(fish, value),1.0,0.0,0.25)
	fish.queue_free()
	SignalBus.fish_destroyed.emit(fish.fish_resource.fish_value)

func set_shader_value(fish:Fish, value:float):
	var sprite = fish.get_node("Sprite2D")
	sprite.material.set_shader_parameter("dissolve_value",value)
