extends Node2D

@export var fish_resource:FishResource

# Called when the node enters the scene tree for the first time.
func _ready():
	if fish_resource:
		fish_resource.on_collision() #this is just for testing. remove later.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_2d_body_entered(body):
	if fish_resource:
		fish_resource.on_collision()
	#make death tween here
	queue_free()

func _on_shot_fired():
	print("wow")
	var tween = get_tree().create_tween()
	tween.tween_property(self,"position",position+Vector2(0,32),0.5).set_trans(Tween.TRANS_SINE)
	#tween.tween_property($Sprite2D, "modulate", Color.RED, 1)
	tween.play()
	
