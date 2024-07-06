extends Fish
class_name Tuna

@export_category("Tuna Attributes")
@export var move_speed: float

@export var timer: Timer

@onready var raycast: RayCast2D = $FishRayCast

var tween: Tween

func _ready() -> void:
	body_entered.connect(destroy)
	timer.timeout.connect(move_fish)
	
func move_fish() -> void:
	var have_collision: bool = await check_collision_before_moving()
	if !have_collision:
		tween = create_tween()
		tween.tween_property(self, 'global_position:x', global_position.x - move_speed, 1)

func destroy(body: Node2D) -> void:
	queue_free()

func check_collision_before_moving() -> bool:
	if raycast.is_colliding():
		return true
	else:
		return false
