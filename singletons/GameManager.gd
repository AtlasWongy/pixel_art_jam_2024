extends Node

enum GAME_STATE {MENU, IN_PROGRESS, PAUSED, GAME_OVER}
var current_state: GAME_STATE

func _ready():
	current_state = GAME_STATE.IN_PROGRESS
	pass # Replace with function body.

func _process(delta):
	pass

func enter_pause_state():
	pass

func enter_game_over_state():
	pass

func enter_menu_state():
	pass

func enter_in_progress_state():
	pass	
