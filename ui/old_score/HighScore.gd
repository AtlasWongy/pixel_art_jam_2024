extends Label

func _ready():
	SignalBus.update_highscore.connect(update_text_score)
	text = str(GameManager.high_score)

func _process(_delta):
	pass

func update_text_score(new_score: int):
	text = str(new_score)
