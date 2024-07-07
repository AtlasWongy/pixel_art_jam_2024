extends Node2D
class_name Movement

@export_category("Fish Movement")
@export var fish: Fish
@export var raycast: RayCast2D
@export var timer: Timer

func _ready():
	timer.timeout.connect(move)

func move() -> void:
	var have_collision: bool = await check_collision_before_moving()
	if !have_collision:
		var tween: Tween = create_tween()
		tween.tween_property(fish, 'global_position:x', global_position.x - 100.0, 1)
	
func check_collision_before_moving() -> bool:
	if raycast.is_colliding():
		return true
	else:
		return false
