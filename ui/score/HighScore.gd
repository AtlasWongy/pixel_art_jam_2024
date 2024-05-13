extends Label

func _ready():
	SignalBus.update_score.connect(update_text_score)
	pass # Replace with function body.

func _process(delta):
	pass

func update_text_score():
	pass
