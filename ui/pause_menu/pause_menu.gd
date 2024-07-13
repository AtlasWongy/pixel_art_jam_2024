extends PanelContainer

var tween: Tween

func _ready() -> void:
	SignalBus.on_pause.connect(turn_on_pause_menu)
	SignalBus.on_unpause.connect(turn_off_pause_menu)
	
func turn_on_pause_menu() -> void:
	tween = create_tween()
	tween.tween_property(self, 'global_position:y', global_position.y + 268.0, 1).finished.connect(reset_menu_to_pausable)

func turn_off_pause_menu() -> void:
	tween = create_tween()
	tween.tween_property(self, 'global_position:y', global_position.y - 268.0, 1).finished.connect(reset_menu_to_pausable)

func reset_menu_to_pausable() -> void:
	SignalBus.on_pause_menu_finish_tweening.emit()
