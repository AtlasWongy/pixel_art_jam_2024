extends Node

var sfx_node = preload("res://audio/sfx_one_shot.tscn")

var fish_destroy_sfx = preload("res://audio/fish_hit.wav")
var shoot_bubble_sfx = preload("res://audio/bubble_shot.wav")
var wall_bounce_sfx = preload("res://audio/wall_bounce.wav")
var fish_spawn_sfx = preload("res://audio/fish_spawn.wav")
var start_game_sfx = preload("res://audio/start_game.wav")

var num_destroyed:int = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	SignalBus.fish_collided.connect(fish_sfx_play)
	SignalBus.shot_completed.connect(reset_fish_sfx)
	SignalBus.shoot_bubble.connect(shoot_bubble_sfx_play)
	SignalBus.bubble_collide_wall.connect(bubble_collide_wall_sfx_play)
	SignalBus.fish_spawned.connect(fish_spawn_sfx_play)
	SignalBus.start_game.connect(start_game_sfx_play)
	$MusicPlayer.play()
	$MusicPlayer.finished.connect(loop_music)

func loop_music():
	$MusicPlayer.play(23.13)

func fish_sfx_play():
	num_destroyed += 1
	var new_sfx_node = sfx_node.instantiate()
	new_sfx_node.pitch_scale += num_destroyed * 0.1
	new_sfx_node.volume_db -= 3
	add_child(new_sfx_node)
	new_sfx_node.play_sound(fish_destroy_sfx)

func reset_fish_sfx():
	num_destroyed = 0

func shoot_bubble_sfx_play(_flag):
	var new_sfx_node = sfx_node.instantiate()
	add_child(new_sfx_node)
	new_sfx_node.play_sound(shoot_bubble_sfx)

func bubble_collide_wall_sfx_play():
	var new_sfx_node = sfx_node.instantiate()
	new_sfx_node.volume_db -= 16
	add_child(new_sfx_node)
	new_sfx_node.play_sound(wall_bounce_sfx)

func fish_spawn_sfx_play():
	var new_sfx_node = sfx_node.instantiate()
	new_sfx_node.volume_db -= 1
	add_child(new_sfx_node)
	new_sfx_node.play_sound(fish_spawn_sfx)
	
func start_game_sfx_play(_flag:bool):
	var new_sfx_node = sfx_node.instantiate()
	new_sfx_node.volume_db -= 1
	add_child(new_sfx_node)
	new_sfx_node.play_sound(start_game_sfx)

