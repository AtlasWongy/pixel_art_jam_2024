extends CharacterBody2D

@export var rotation_speed = 1.5

var rotation_direction = 0

func get_input():
	rotation_direction = Input.get_axis("left_arrow", "right_arrow")

func _physics_process(delta):
	get_input()
	if rotation > 0.8:
		rotation -= 0.025
		return
	elif rotation < -0.8:
		rotation += 0.025
		return
	else:
		rotation += rotation_direction * rotation_speed * delta
	if Input.is_action_just_pressed("ui_accept"):
		print("Fire the ball")
	
