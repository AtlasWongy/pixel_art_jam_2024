extends Node2D
class_name Fish

@export var fish_resource:FishResource

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
			fish_resource.on_collision(body) #i'm just going to assume that the only bodies moving around are the bubble - DG
	#make death tween here
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
	
