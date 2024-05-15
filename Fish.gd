extends Node2D

@export var fish_resource:FishResource

# Called when the node enters the scene tree for the first time.
func _ready():
	if fish_resource:
		fish_resource.on_collision() #this is just for testing. remove later.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func _on_area_2d_body_entered(_body):
	if fish_resource:
		fish_resource.on_collision()
	#make death tween here
	queue_free()
	SignalBus.fish_destroyed.emit()

func _on_shot_fired():
	var tween = get_tree().create_tween()
	tween.tween_property(self,"position",position+Vector2(0,32),0.5).set_trans(Tween.TRANS_SINE)
	#tween.tween_property($Sprite2D, "modulate", Color.RED, 1)
	tween.play()
	
func _toggle_visibility(show_flag:bool):
	self.visible = show_flag
	
