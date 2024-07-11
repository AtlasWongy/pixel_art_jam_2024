extends Node
class_name UIManager

var current_score: int

func _ready() -> void:
	SignalBus.on_score.connect(update_score)
	#SignalBus.on_game_pause.connect(toggle_pause_menu)
	
func update_score(score: int) -> void:
	current_score += score
	SignalBus.update_score_ui.emit(current_score)
	
#func toggle_pause_menu(is_paused: bool) -> void:
	#if is_paused:
		#print("Bring down the menu")
	#else:
		#print("Bring up the menu")
