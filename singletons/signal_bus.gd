extends Node

signal shot_completed() #emitted when ball hits lower boundary
signal fish_collision()
signal changed_player_rotation(player_rotation:float, player_position:Vector2)
signal shoot_bubble(player_rotation:float)
signal bubble_collide_wall()
signal update_score
signal fish_destroyed(score: int)
signal game_over

signal start_game(game_started:bool)
signal game_state(indicator:int)
signal toggle_menu_visibility(show:bool)
signal toggle_characters_visibility(show:bool)
signal toggle_in_game_menu_visibility(show:bool)

signal nearest_enemy_position(fish_position:float)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
