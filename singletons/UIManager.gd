extends Node

var menu_visibility
var characters_visibility
var in_game_menu_visibility

func _ready():
	#SignalBus.start_game.connect(game_started)
	var game_state = GameManager.game_state
	game_started(game_state)
	SignalBus.game_state.connect(game_started)

func game_started(game_state:int):
	if game_state==1:
		menu_visibility = false
		characters_visibility = true
		in_game_menu_visibility = true
	elif game_state==0 || game_state==2:
		menu_visibility = true
		characters_visibility = false
		in_game_menu_visibility = false
	
	handle_visibility()

func handle_visibility():
	SignalBus.toggle_menu_visibility.emit(menu_visibility)
	SignalBus.toggle_characters_visibility.emit(characters_visibility)
	SignalBus.toggle_in_game_menu_visibility.emit(in_game_menu_visibility)
