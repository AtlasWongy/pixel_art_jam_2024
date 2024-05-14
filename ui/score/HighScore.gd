extends Label

@export var score: int = 0

func _ready():
	SignalBus.fish_destroyed.connect(update_text_score)
	text = str(score)
	pass # Replace with function body.

func _process(delta):
	pass

func update_text_score():
	score += 10
	text = str(score)
	print("Destroyed")
