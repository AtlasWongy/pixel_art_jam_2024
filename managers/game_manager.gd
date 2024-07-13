extends Node

enum GameState {IDLE, RUNNING, ENDED, PAUSED}

var can_pause: bool
var game_state: GameState

func _ready() -> void:
	if game_state != GameState.RUNNING: 
		game_state = GameState.RUNNING
	process_mode = Node.PROCESS_MODE_ALWAYS
	can_pause = true 
	SignalBus.on_pause_menu_finish_tweening.connect(reset_to_pausable)
	
func _process(delta: float) -> void:
	if game_state == GameState.RUNNING and Input.is_action_just_pressed("pause") and can_pause:
		pause_game()
	elif game_state == GameState.PAUSED and Input.is_action_just_pressed("pause") and can_pause:
		unpause_game()

func pause_game() -> void:
	can_pause = false
	get_tree().paused = true
	SignalBus.on_pause.emit()
	game_state = GameState.PAUSED

func unpause_game() -> void:
	can_pause = false
	get_tree().paused = false
	SignalBus.on_unpause.emit()
	game_state = GameState.RUNNING
	
func reset_to_pausable() -> void:
	can_pause = true
