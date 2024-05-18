extends Node2D

func _ready():
	toggle_visibility(UiManager.in_game_menu_visibility)
	SignalBus.toggle_in_game_menu_visibility.connect(toggle_visibility)
	SignalBus.toggle_pause_menu_visibility.connect(toggle_pause_menu_visibility)
	
func toggle_visibility(show_flag:bool):
	# Hide the node if it has a visibility property
	if self is CanvasItem:
		self.visible = show_flag
		
	var highScore = $GridContainer/HighScore
	if !show_flag:
		highScore.reset_text_score(GameManager.game_score)

func pause_game(paused_flag:bool):
	var pause_menu_panel = $Panel
	if paused_flag:
		print("Paused game!")
	else:
		print("Resumed game!")
	#pause_menu_panel.visible = paused_flag
	SignalBus.game_paused.emit(paused_flag)

func toggle_pause_menu_visibility(show_flag:bool):
	var pause_menu_panel = $Panel
	pause_menu_panel.visible = show_flag
	
func exit_game():
	get_tree().quit()

