extends Node2D

func _ready():
	toggle_visibility(UiManager.in_game_menu_visibility)
	SignalBus.toggle_in_game_menu_visibility.connect(toggle_visibility)

func toggle_visibility(show_flag:bool):
	# Hide the node if it has a visibility property
	if self is CanvasItem:
		self.visible = show_flag
		
	var highScore = $GridContainer/HighScore
	if !show_flag:
		highScore.reset_text_score(GameManager.game_score)
