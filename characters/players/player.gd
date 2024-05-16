extends CharacterBody2D

@export var rotation_speed = 3.0
@export var max_rotation = 1.309

var rotation_direction = 0
var movable = false

func _ready():
	toggle_visibility(UiManager.characters_visibility)
	SignalBus.toggle_characters_visibility.connect(toggle_visibility)

func get_rotation_input(delta):
	if movable:
		rotation_direction = Input.get_axis("left_arrow", "right_arrow")
	if rotation >= max_rotation:
		if rotation_direction < 0:
			rotation -= 0.025
			return
		elif rotation_direction > 0:
			print("Reached right rotation limit")
	elif rotation <= -max_rotation:
		if rotation_direction > 0:
			rotation += 0.025
			return
		elif rotation_direction < 0:
			print("Reached left rotation limit")
	else:
		rotation += rotation_direction * rotation_speed * delta
		
func _physics_process(delta):
	get_rotation_input(delta)
	SignalBus.changed_player_rotation.emit(rotation, global_position)
		
	if Input.is_action_just_pressed("ui_accept") && movable:
		SignalBus.shoot_bubble.emit(rotation)
		
func toggle_visibility(show_flag:bool):
	print("player ", show_flag)
	self.visible = show_flag
	movable = show_flag
