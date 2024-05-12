extends RigidBody2D

class_name Bubble

@export var initial_bubble_speed = 20
# 102% faster every time it hits something
@export var speed_multiplier   = 1.02
@export var distance_from_player = 25

var bubble_speed = initial_bubble_speed
var player_rotation = 0  # Store the player's rotation

var set_to_starting_state = true

func _ready():
	#start_bubble()
	SignalBus.changed_player_rotation.connect(update_postition)
	SignalBus.shoot_bubble.connect(start_bubble_movement)
	
func _physics_process(delta):
	toggle_starting_state()
	var collision = move_and_collide(linear_velocity * bubble_speed * delta)
	if (collision):
		linear_velocity = linear_velocity.bounce(collision.get_normal()) * speed_multiplier
		
func start_bubble_movement():
	if set_to_starting_state:
		set_to_starting_state = false
		print("Fire the bubble")
		 # Calculate the direction vector based on the rotation angle
		var direction = Vector2(0, -distance_from_player).rotated(player_rotation)
		# Set the linear velocity of the ball
		linear_velocity = direction.normalized() * initial_bubble_speed
		#randomize()
		#linear_velocity.x = [-1, 1][randi() % 2] * initial_bubble_speed
		#linear_velocity.y = [-8, 8][randi() % 2] * initial_bubble_speed

func update_postition(rotation:float):
	if set_to_starting_state:
		player_rotation = rotation
		global_position = get_parent().get_node("Player").global_position + Vector2(0, -distance_from_player).rotated(player_rotation)
		#global_position = get_parent().get_node("Player").global_position + Vector2.RIGHT.rotated(player_rotation*(PI / 180.0))
		#global_position = get_parent().get_node("Player").global_position + Vector2(cos(player_rotation), sin(player_rotation)).normalized() * distance_from_player

func toggle_starting_state():
	if position.y > get_viewport_rect().size.y:
		print("Shot ended")
		set_to_starting_state = true
		linear_velocity.x = 0
		linear_velocity.y = 0
