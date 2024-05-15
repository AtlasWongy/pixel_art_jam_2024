extends Node

func _ready():
	#SignalBus.start_game.connect(game_started)
	SignalBus.game_state.connect(game_started)

func game_started(indicator:int):
	print("Game State: ", indicator)
	if indicator==1:
		SignalBus.toggle_menu_visibility.emit(false)
		SignalBus.toggle_characters_visibility.emit(true)
		SignalBus.toggle_in_game_menu_visibility.emit(true)
	elif indicator==0:
		SignalBus.toggle_menu_visibility.emit(true)
		SignalBus.toggle_characters_visibility.emit(false)
		SignalBus.toggle_in_game_menu_visibility.emit(false)


