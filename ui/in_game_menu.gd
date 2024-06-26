extends Node2D

func _ready():
	toggle_visibility(UiManager.in_game_menu_visibility)
	SignalBus.toggle_in_game_menu_visibility.connect(toggle_visibility)
	SignalBus.toggle_pause_menu_visibility.connect(toggle_pause_menu_visibility)
	
func toggle_visibility(show_flag:bool):
	# Hide the node if it has a visibility property
	if self is CanvasItem:
		self.visible = show_flag
		
	var currentScore = $CurrentScoreContainer/CurrentScore
	if !show_flag:
		currentScore.reset_text_score(GameManager.game_score)

func pause_game(paused_flag:bool):
	if paused_flag:
		print("Paused game!")
	else:
		print("Resumed game!")

	SignalBus.game_paused.emit(paused_flag)

func toggle_pause_menu_visibility(show_flag:bool):
	var pause_menu_panel = $PausePanel
	pause_menu_panel.visible = show_flag
	get_tree().paused = show_flag
	
func exit_game():
	FileManager.save_game()
	get_tree().quit()

