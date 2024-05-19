extends Label

@export var score: int = 0

func _ready():
	SignalBus.fish_destroyed.connect(update_text_score)
	text = str(score)

func _process(_delta):
	pass

func update_text_score(new_score: int):
	score += new_score
	text = str(score)
	GameManager.get_current_score(score)
	
func reset_text_score(base_score:int):
	score = base_score
	text = str(score)
