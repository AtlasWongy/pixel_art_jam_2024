extends Node

enum GameState {IDLE, RUNNING, ENDED}

var game_state

func _ready():
	game_state = GameState.IDLE
	SignalBus.start_game.connect(game_started)
	SignalBus.game_state.emit(game_state)
	SignalBus.nearest_enemy_position.connect(game_over)
	
func game_started(start_game:bool):
	if start_game:
		game_state = GameState.RUNNING
	else:
		game_state = GameState.IDLE
	SignalBus.game_state.emit(game_state)

func game_over(fish_position:float):
	var player_y_position = get_parent().get_node("Player").global_position.y
	if fish_position >= player_y_position:
		print("GAMEOVER!")

func _process(_delta):
	pass
