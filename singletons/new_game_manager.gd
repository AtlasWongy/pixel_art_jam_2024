extends Node

@export var player_data: SaveInfo = SaveInfo.new()
var player_scene: PackedScene = preload("res://test/player.tscn")
var current_scene = null
var player: Player

var current_points: int
var save_path = "res://save/save_data.tres"

func _ready():
	SignalBus.set_points.connect(_on_set_points)
	SignalBus.set_game_to_end.connect(_on_set_game_end)
	
	load_save_data()
	var root = get_tree().root
	current_scene = root.get_child(root.get_child_count() - 1)
	
func _on_set_points():
	current_points += 1
	print("The current points is: ", current_points)
	
func save_data():
	player_data.points = current_points
	player_data.health = player.health
	ResourceSaver.save(player_data, save_path)
	
func load_save_data():
	var res: SaveInfo = load(save_path)
	
	player = player_scene.instantiate()
	current_points = res.points
	player.health = res.health
	add_child(player)
	
func _on_set_game_end():
	save_data()
	
	var timer: Timer = Timer.new()
	add_child(timer)
	timer.wait_time = 2.5
	timer.start()
	await timer.timeout
	
	get_tree().quit()
	
func switch_scene():
	call_deferred("_deferred_switch_scene", "res://test/test_next_scene.tscn")

func _deferred_switch_scene(res_path):
	
	# Save the scene
	save_data()
	player.queue_free()
	
	current_scene.free()
	var s = load(res_path)
	current_scene = s.instantiate()
	get_tree().root.add_child(current_scene)
	get_tree().current_scene = current_scene
	
	# Load the scene
	load_save_data()

