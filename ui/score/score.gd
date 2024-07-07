extends Label

func _ready():
	SignalBus.update_score_ui.connect(update_score)
	
func update_score(score: int):
	text = str(score)
