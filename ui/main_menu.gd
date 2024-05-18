extends Node2D

var game_state

func _ready():
	get_game_state(GameManager.game_state)
	SignalBus.game_state.connect(get_game_state)
	SignalBus.toggle_menu_visibility.connect(toggle_visibility)

func get_game_state(indicator:int):
	game_state = indicator
	toggle_visibility(UiManager.menu_visibility)
	
func click_play_button():
	print("play button clicked")
	if game_state == 0 || game_state == 2:
		SignalBus.start_game.emit(true)
	elif game_state == 1:
		SignalBus.start_game.emit(false)
	
func toggle_visibility(show_flag:bool):
	# Hide the node if it has a visibility property
	if self is CanvasItem:
		self.visible = show_flag
	
	# Show text as Restart or Play
	if show_flag:
		var title = $GameName
		var playButton = $PlayButton
		if game_state == 1:
			title.text = "ARCHER FISH"
			playButton.text = "Play"
		elif game_state == 2:
			title.text = "GAME OVER!"
			playButton.text = "Restart"

func exit_game():
	get_tree().quit()

