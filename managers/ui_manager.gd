extends Node
class_name UIManager

var current_score: int

func _ready() -> void:
	SignalBus.on_score.connect(update_score)
	
func update_score(score: int) -> void:
	current_score += score
	SignalBus.update_score_ui.emit(current_score)
