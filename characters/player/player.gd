extends CharacterBody2D

@export_category("Rotation Values")
@export var rotation_speed: float = 3.0
@export var upper_limit_rotation: float = 1.039
@export var lower_limit_rotation: float = 0.0

@export_category("Trajectory Line")
@export var trajectory_line: Line2D

var bubble_load: Resource = preload("res://characters/player/bubble/bubble.tscn")
var rotation_direction: int = 0
var can_control: bool = true

func _ready() -> void:
	SignalBus.bubble_finished.connect(toggle_control)
	
func _process(delta: float) -> void:
	trajectory_line.rotation = -rotation
	trajectory_line.update_trajectory(global_transform.x, -20.0, delta)

func _physics_process(delta: float) -> void:
	get_rotation_input(delta)
	
func _input(event) -> void:
	if event.is_action_pressed("ui_accept") and can_control:
		var bubble: RigidBody2D = bubble_load.instantiate()
		add_child(bubble)
		bubble.player_rotation = rotation
		bubble.fire_bubble()
		toggle_control()

func get_rotation_input(delta: float) -> void:
	if can_control:
		rotation_direction = Input.get_axis("left_arrow", "right_arrow")
		if rotation < lower_limit_rotation:
			if rotation_direction > 0:
				rotation += 0.025
		elif rotation > upper_limit_rotation:
			if rotation_direction < 0:
				rotation -= 0.025
		else:
			rotation += rotation_direction * rotation_speed * delta
			return

func toggle_control() -> void:
	can_control = !can_control
