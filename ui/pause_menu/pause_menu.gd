extends PanelContainer

var tween: Tween

func _ready():
	SignalBus.on_game_pause.connect(toggle_pause_menu)
	
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("pause"):
		# Pause Menu detects the pause Input
		print("Try to unpause")
	
func toggle_pause_menu(paused: bool):
	tween = create_tween()
	if paused:
		tween.tween_property(self, 'global_position:y', global_position.y + 268.0, 1)
	else:
		tween.tween_property(self, 'global_position:y', global_position.y - 268.0, 1)
