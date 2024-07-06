extends Node2D

@export_category("Initial Spawn Points")
@export var initial_spawn_points: Array[Vector2]

@export_category("Fishes")
@export var tuna: PackedScene

@onready var spawn_area: Area2D = $SpawnArea
@onready var destroy_area: Area2D = $DestroyArea

var enemy_dictionary: Dictionary
var total_fish_spawn: int = 0

func _ready() -> void:
	spawn_area.area_exited.connect(counting_next_spawn_counter)
	destroy_area.area_entered.connect(let_fish_escape)
	init_enemy_dictionary()
	spawn_fishes()

func init_enemy_dictionary() -> void:
	enemy_dictionary[1] = tuna

func spawn_fishes() -> void:
	for spawn_point in initial_spawn_points:
		var idx: int = randi() % 2
		if idx != 0:
			var fish_scene: PackedScene = enemy_dictionary[idx]
			if fish_scene.can_instantiate():
				var fish: Fish = fish_scene.instantiate()
				fish.position = spawn_point
				call_deferred("add_child", fish)
				total_fish_spawn += 1

func counting_next_spawn_counter(area: Area2D) -> void:
	total_fish_spawn -= 1
	if total_fish_spawn == 0:
		spawn_fishes()

func let_fish_escape(area: Area2D) -> void:
	if area is Fish:
		area.queue_free()
