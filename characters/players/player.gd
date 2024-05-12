extends CharacterBody2D

@export var rotation_speed = 1.5

var rotation_direction = 0

func get_rotation_input(delta):
	rotation_direction = Input.get_axis("left_arrow", "right_arrow")
	if rotation > 0.8:
		if rotation_direction < 0:
			rotation -= 0.025
			print(rotation)
			return
	elif rotation < -0.8:
		if rotation_direction > 0:
			rotation += 0.025
			print(rotation)
			return
	else:
		rotation += rotation_direction * rotation_speed * delta
	
		
func _physics_process(delta):
	get_rotation_input(delta)
	
	SignalBus.changed_player_rotation.emit(rotation)
		
	if Input.is_action_just_pressed("ui_accept"):
		SignalBus.shoot_bubble.emit()
	
