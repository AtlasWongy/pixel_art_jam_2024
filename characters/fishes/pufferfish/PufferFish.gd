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
			await play_animation(fish)
		death_tween_function(fish)

func get_explosion_flag() -> bool:
	return exploded

func play_animation(fish:Fish):
	var tween = fish.create_tween()
	var sprite = fish.get_node("Sprite2D")

	# Animate the scale using the tween
	tween.tween_property(sprite, "scale", Vector2(6,6), 1)
	
	# Tween for the collision shape scaling
	var collision_shape = fish.get_node("Area2D")
	tween.parallel().tween_property(collision_shape, "scale", Vector2(6,6), 1)

	await tween.finished
	
func death_tween_function(fish:Fish):
	var death_tween = fish.create_tween()
	death_tween.tween_method(func(value):
			set_shader_value(fish, value),1.0,0.0,0.25)
	fish.queue_free()
	SignalBus.fish_destroyed.emit(fish.fish_resource.fish_value)

func set_shader_value(fish:Fish, value:float):
	var sprite = fish.get_node("Sprite2D")
	sprite.material.set_shader_parameter("dissolve_value",value)
