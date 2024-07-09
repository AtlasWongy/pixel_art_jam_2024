extends Button
class_name StartButton

@export var main_game: PackedScene

func _ready() -> void:
	pressed.connect(enter_game_scene)
	
func enter_game_scene() -> void:
	SceneManager.goto_scene(main_game)
