extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	SignalBus.shot_completed.connect(_move_fish)
	SignalBus.toggle_characters_visibility.connect(toggle_visibility)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func _move_fish():
	get_tree().call_group("Fish","_on_shot_fired")
	var _scene_tree = SceneTree.new()
	print("Fish surviving: ", get_tree().has_group("Fish"))
	
	if get_tree().has_group("Fish"):
		var fish_position = get_fish_nearest_to_bottom()
		SignalBus.nearest_enemy_position.emit(fish_position)
		
func toggle_visibility(show:bool):
	get_tree().call_group("Fish","_toggle_visibility", show)
	print("fishes ", show)

func get_fish_nearest_to_bottom() -> float:
	var bottom_fish = null
	var min_y = INF 
	
	for fish in get_tree().get_nodes_in_group("Fish"):
		if fish.global_position.y > min_y:
			min_y = fish.global_position.y
			bottom_fish = fish
			
	return bottom_fish.global_position.y
