extends Node

var shots_fired:int = 0
var default_location: Vector2 = Vector2(40,40)

var fish = preload("res://Fish.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	toggle_visibility(UiManager.characters_visibility)
	SignalBus.shot_completed.connect(_move_fish)
	SignalBus.toggle_characters_visibility.connect(toggle_visibility)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _spawn_fish():
	var new_fish = fish.instantiate()
	

func _move_fish():
	shots_fired += 1
	get_tree().call_group("Fish","_on_shot_fired")
	var _scene_tree = SceneTree.new()
	print("Fish surviving: ", get_tree().has_group("Fish"))
	
	if get_tree().has_group("Fish"):
		var game_over_flag = get_fish_nearest_to_bottom()
		SignalBus.enemy_won.emit(game_over_flag)
		if game_over_flag:
			clear_remaining_fish()
		
func toggle_visibility(show:bool):
	get_tree().call_group("Fish","_toggle_visibility", show)
	print("fishes ", show)

func get_fish_nearest_to_bottom() -> bool:
	var reached_end = false
	var player_y_position = get_parent().get_node("Player").global_position.y 
	
	for fish in get_tree().get_nodes_in_group("Fish"):
		if fish.global_position.y >= player_y_position:
			reached_end = true
			
	return reached_end
	
func clear_remaining_fish():
	for fish in get_tree().get_nodes_in_group("Fish"):
		fish.queue_free()
