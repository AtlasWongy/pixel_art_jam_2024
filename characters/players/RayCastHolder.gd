extends Node2D

@onready var player: CharacterBody2D = $".."

@export var current_raycast: RayCast2D

var current_origin_point: Vector2

func _ready():
	current_origin_point = player.global_position
	pass

func _process(delta):
	if current_raycast.is_colliding():
		create_raycast()
	pass
	
func create_raycast():
	var spawn_point = current_raycast.get_collision_point()
	
	#print("Collision Point: ", spawn_point)
	
	var normal = current_raycast.get_collision_normal()
	
	var incoming_direction = spawn_point - current_origin_point
	#
	#print("The incoming direction is: ", incoming_direction)
	#
	var outgoing_direction = incoming_direction.bounce(normal)
	#
	#print("The outgoing direction is: ", outgoing_direction)
	#
	var raycast = RayCast2D.new()
	raycast.enabled = true
	raycast.exclude_parent = true
	raycast.target_position = Vector2(120.9688, 2000)
	call_deferred("add_child", raycast)
	#print("Created")
