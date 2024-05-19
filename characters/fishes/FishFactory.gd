extends Node


var default_location: Vector2 = Vector2(64,64)

var fish = preload("res://characters/fishes/Fish.tscn")

var fish_to_spawn: int = 3
var rows_to_spawn: int = 1

var shots_since_last_increase: int = 0
#assuming there are 9 "spawning points"
var spawn_array = [1,2,3,4,5,6,7,8,9]
var available_fish_id = [2, 4, 5] # to be updated
var _spawn_array = []


# Called when the node enters the scene tree for the first time.
func _ready():
	toggle_visibility(UiManager.characters_visibility)
	SignalBus.shot_completed.connect(_move_fish)
	SignalBus.toggle_characters_visibility.connect(toggle_visibility)
	SignalBus.start_game.connect(_on_game_start)
	
	ResourceUID.add_id(0,"res://characters/fishes/tuna/tuna.tres")
	ResourceUID.add_id(1,"res://characters/fishes/glassfish/GlassFish.tres")
	ResourceUID.add_id(2,"res://characters/fishes/rockfish/Rockfish.tres")
	ResourceUID.add_id(4,"res://characters/fishes/glassfish/GlassFish.tres")
	ResourceUID.add_id(5,"res://characters/fishes/swordfish/Swordfish.tres")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _spawn_fish():
	_spawn_array = spawn_array
	_spawn_array.shuffle()
	_spawn_array = _spawn_array.slice(0,fish_to_spawn)
	_spawn_array.sort()
	for i in fish_to_spawn:
		var new_fish = fish.instantiate()
		new_fish.position = default_location + Vector2(64,0) * (_spawn_array.pop_front()-1)
		
		# var fish_id = randi_range(1,FileManager.fishes.size())
		# To be updated
		var random_index = randi() % available_fish_id.size()
		var selected_fish_index = available_fish_id[random_index]
		
		new_fish.fish_resource = load(ResourceUID.get_id_path(selected_fish_index))
		new_fish.fish_resource.fish_value = FileManager.get_fish_score_by_id(selected_fish_index)
		add_child(new_fish)

func _on_game_start(value:bool):
	if value:
		fish_to_spawn = 3
		rows_to_spawn = 1
		shots_since_last_increase = 0
		_spawn_all_fish()

func _move_fish():
	shots_since_last_increase += 1
	get_tree().call_group("Fish","_on_shot_fired")
	var _scene_tree = SceneTree.new()
	print("Fish surviving: ", get_tree().has_group("Fish"))
	
	if get_tree().has_group("Fish"):
		var game_over_flag = get_fish_nearest_to_bottom()
		SignalBus.enemy_won.emit(game_over_flag)
		if game_over_flag:
			clear_remaining_fish()
		else:
			if shots_since_last_increase >= 3:
				fish_to_spawn += 1
				if fish_to_spawn >= 7:
					fish_to_spawn = 3
					rows_to_spawn += 1
				
			_spawn_all_fish()
	else:
		#player cleared all fish? time to spawn a lot more
		rows_to_spawn += 1
		_spawn_all_fish()

func _spawn_all_fish():
	for i in rows_to_spawn:
		SignalBus.fish_spawned.emit()
		print(i)
		print(rows_to_spawn)
		await get_tree().create_timer(0.5).timeout
		_spawn_fish()
		if i+1 != rows_to_spawn:
			get_tree().call_group("Fish","_on_shot_fired")
	
	rows_to_spawn = 1

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
