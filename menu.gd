extends Node2D

var game_state


func _ready():
	SignalBus.game_state.connect(get_game_state)
	SignalBus.toggle_menu_visibility.connect(toggle_visibility)

func get_game_state(indicator:int):
	game_state = indicator

func click_play_button():
	print("play button clicked")  
	if game_state == 0:
		SignalBus.start_game.emit(true)
	elif game_state == 1:
		SignalBus.start_game.emit(false)

	
func toggle_visibility(show:bool):
	# Hide the node if it has a visibility property
	if self is CanvasItem:
		self.visible = show


