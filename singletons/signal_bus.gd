extends Node

signal shot_completed() #emitted when ball hits lower boundary
signal start_shot()
signal reset_ball() 
signal fish_collided() #for sfx
signal changed_player_rotation(player_rotation:float, player_position:Vector2)
signal shoot_bubble(player_rotation:float)
signal bubble_collide_wall()
signal fish_destroyed(score: int)
signal completed_collision_effects
signal fish_spawned
signal update_highscore(score: int)

signal start_game(game_started:bool)
signal game_state(indicator:int)
signal toggle_menu_visibility(show:bool)
signal toggle_characters_visibility(show:bool)
signal toggle_in_game_menu_visibility(show:bool)
signal game_paused(paused_flag:bool)
signal toggle_pause_menu_visibility(show:bool)

signal enemy_won(game_over_flag:bool)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
