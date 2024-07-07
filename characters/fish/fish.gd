extends Node2D
class_name Fish

#@export var fish_resource: FishResource
#
#var timer: Timer
#var raycast: RayCast2D
#var tween: Tween

#func _ready() -> void:
	#timer = get_node(fish_resource.timer_node_path)
	#raycast = get_node(fish_resource.raycast_node_path)
	#
	#body_entered.connect(destroy)
	#timer.timeout.connect(move_fish)
	
#func move_fish() -> void:
	#var have_collision: bool = await check_collision_before_moving()
	#if !have_collision:
		#tween = create_tween()
		#tween.tween_property(self, 'global_position:x', global_position.x - 100.0, 1)

#func destroy(body: Node2D) -> void:
	#print("You must implement this method!")

#func check_collision_before_moving() -> bool:
	#if raycast.is_colliding():
		#return true
	#else:
		#return false
