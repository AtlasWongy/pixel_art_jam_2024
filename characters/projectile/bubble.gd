extends RigidBody2D

class_name Bubble

@export var initial_bubble_speed = 20
# 102% faster every time it hits something
@export var speed_multiplier   = 1.02
@export var distance_from_player = 25

var bubble_speed = initial_bubble_speed
#var player_rotation = 0  # Store the player's rotation

var set_to_starting_state = true

func _ready():
	#start_bubble()
	SignalBus.changed_player_rotation.connect(update_postition)
	SignalBus.shoot_bubble.connect(start_bubble_movement)
	
func _physics_process(delta):
	toggle_starting_state()
	var collision = move_and_collide(linear_velocity * bubble_speed * delta)
	if (collision):
		var collider = collision.get_collider()
		var shape_index = collision.get_collider_shape_index()
		var shape_owner_id = collider.shape_find_owner(shape_index)
		var shape_owner = collider.shape_owner_get_owner(shape_owner_id)
		if shape_owner:
			print("Collided with: ", shape_owner.name)
			if shape_owner.name.contains("Boundary"):
				SignalBus.bubble_collide_wall.emit()
				linear_velocity = linear_velocity.bounce(collision.get_normal()) * speed_multiplier
		else:
			print("Collided with: ", collider.name)
		
func start_bubble_movement(player_rotation:float):
	if set_to_starting_state:
		set_to_starting_state = false
		 # Calculate the direction vector based on the rotation angle
		var direction = Vector2(0, -distance_from_player).rotated(player_rotation)
		# Set the linear velocity of the ball
		linear_velocity = direction.normalized() * initial_bubble_speed
		#randomize()
		#linear_velocity.x = [-1, 1][randi() % 2] * initial_bubble_speed
		#linear_velocity.y = [-8, 8][randi() % 2] * initial_bubble_speed

func update_postition(player_rotation:float, player_position:Vector2):
	if set_to_starting_state:
		global_position = player_position + Vector2(0, -distance_from_player).rotated(player_rotation)
		#player_rotation = rotation_changed
		#global_position = get_parent().get_node("Player").global_position + Vector2(0, -distance_from_player).rotated(player_rotation)
		#global_position = get_parent().get_node("Player").global_position + Vector2.RIGHT.rotated(player_rotation*(PI / 180.0))
		#global_position = get_parent().get_node("Player").global_position + Vector2(cos(player_rotation), sin(player_rotation)).normalized() * distance_from_player

func toggle_starting_state():
	if position.y > get_viewport_rect().size.y:
		set_to_starting_state = true
		linear_velocity.x = 0
		linear_velocity.y = 0
		SignalBus.shot_completed.emit()
