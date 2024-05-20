extends Node2D
class_name Fish

@export var fish_resource: FishResource

var collided:bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	if fish_resource.fish_sprite:
		$Sprite2D.texture = fish_resource.fish_sprite
	
	if fish_resource.has_method("fish_init"):
		fish_resource.fish_init(self)
	
	$Sprite2D.material.set_shader_parameter("highlight",false) #set this to true when you want to turn on the shield
	var death_tween = create_tween()
	death_tween.tween_method(set_shader_value,0.0,1.0,0.15)
	
	SignalBus.shot_completed.connect(detect_adjacent_fishes)
	SignalBus.move_zebra.connect(move_forward_again)
	
func _physics_process(_delta):
	if fish_resource.has_method("fish_physics"):
		fish_resource.fish_physics()

func _on_area_2d_body_entered(body):
	if collided:
		return
	else:
		collided = true

	SignalBus.fish_collided.emit()
	if fish_resource:
		if fish_resource.has_method("on_collision_with_body_param"):
			fish_resource.on_collision_with_body_param(body,self)
		else:
			fish_resource.on_collision(body)

		if fish_resource.has_shield:
			fish_resource.has_shield = false
			collided = false
			return
		else:
			if !fish_resource.has_method("play_animation"):
				var death_tween = create_tween()
				death_tween.tween_method(set_shader_value,1.0,0.0,0.25)
				death_tween.tween_callback(_on_fish_destroyed_tween_complete)


func set_shader_value(value:float):
	$Sprite2D.material.set_shader_parameter("dissolve_value",value)

func _on_fish_destroyed_tween_complete():
	queue_free()
	SignalBus.fish_destroyed.emit(fish_resource.fish_value)

func _on_shot_fired():
	var tween = get_tree().create_tween()
	tween.tween_property(self,"position",position+Vector2(0,32),0.5).set_trans(Tween.TRANS_SINE)
	#tween.tween_property($Sprite2D, "modulate", Color.RED, 1)
	
func _toggle_visibility(show_flag:bool):
	self.visible = show_flag

func add_shield():
	if !fish_resource.has_shield and !is_in_group("coral"):
		fish_resource.has_shield = true
		print("Shield turn on!")

func collision_from_other_fishes(body):
	if body.get_parent().fish_resource is Pufferfish && body.get_parent().fish_resource.get_explosion_flag():
		if !fish_resource.has_shield:
			var death_tween = create_tween()
			death_tween.tween_method(set_shader_value,1.0,0.0,0.25)
			death_tween.tween_callback(_on_fish_destroyed_tween_complete)
		else:
			fish_resource.has_shield = false
			
func move_forward_again():
	if is_instance_valid(self):	
		if self.fish_resource is ZebraFish:
			print("zebra adjacent: ", self.fish_resource.move_foward_flag)
			print("zebra in front: ", self.fish_resource.no_fish_infront_flag)
			if (self.fish_resource.move_foward_flag && !self.fish_resource.no_fish_infront_flag):
				print("zebra fish can move!")
				var tween = self.get_tree().create_tween()
				tween.tween_property(self,"position",position+Vector2(0,64),0.5).set_trans(Tween.TRANS_SINE)
				await tween.finished	

func detect_adjacent_fishes():
	if fish_resource.has_method("detect_adjacent_fishes"):
		fish_resource.detect_adjacent_fishes(self)

