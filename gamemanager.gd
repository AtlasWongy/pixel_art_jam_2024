extends Node

enum GameState {IDLE, RUNNING, ENDED}

var game_state

func _ready():
	game_state = GameState.IDLE
	SignalBus.start_game.connect(game_started)
	SignalBus.game_state.emit(game_state)
	SignalBus.toggle_characters_visibility.emit(false)
	
func game_started(start_game:bool):
	if start_game:
		game_state = GameState.RUNNING
		SignalBus.toggle_menu_visibility.emit(false)
		SignalBus.toggle_characters_visibility.emit(true)
		print("Game State: ", game_state)
	else:
		game_state = GameState.IDLE
		SignalBus.toggle_menu_visibility.emit(true)
		SignalBus.toggle_characters_visibility.emit(false)
		print("Game State: ", game_state)
	SignalBus.game_state.emit(game_state)
	
func _process(_delta):
	pass
