extends Node2D
class_name Player

var health: int
	
func _input(event):
	if event.is_action_pressed("ui_accept"):
		SignalBus.set_points.emit()
		
	if event.is_action_pressed("ui_cancel"):
		SignalBus.set_game_to_end.emit()
		
	if event.is_action_pressed("stats"):
		print("My health is: ", health)
		
	if event.is_action_pressed("damage"):
		health -= 1
		print("Receiving damage.. my health is now: ", health)
	
	if event.is_action_pressed("next"):
		print("Next level.......")
		NewGameManager.switch_scene()
