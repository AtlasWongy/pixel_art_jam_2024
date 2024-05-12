extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	SignalBus.shot_completed.connect(_move_fish)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _move_fish():
	get_tree().call_group("Fish","_on_shot_fired")
	var scene_tree = SceneTree.new()
	print(get_tree().has_group("Fish"))
