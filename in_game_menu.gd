extends Node2D


func _ready():
	SignalBus.toggle_in_game_menu_visibility.connect(toggle_visibility)
	
	
func toggle_visibility(show_flag:bool):
	# Hide the node if it has a visibility property
	if self is CanvasItem:
		self.visible = show_flag
