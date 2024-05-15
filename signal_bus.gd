extends Node

signal shot_completed() #emitted when ball hits lower boundary
signal fish_collision()
signal changed_player_rotation
signal shoot_bubble
signal update_score
signal fish_destroyed(score: int)
signal game_over

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
