extends Label

@export var score: int = 0

func _ready():
	SignalBus.fish_destroyed.connect(update_text_score)
	text = str(score)
	pass # Replace with function body.

func _process(_delta):
	pass

func update_text_score():
	score += 10
	text = str(score)
	print("Destroyed")
	
func reset_text_score(base_score:int):
	text = str(base_score)
