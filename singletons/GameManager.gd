extends Node

enum GameState {IDLE, RUNNING, ENDED, PAUSED}

var game_state
var game_score = 0

func _ready():
	game_state = GameState.IDLE
	print("Game State: ", game_state)
	SignalBus.start_game.connect(game_started)
	SignalBus.enemy_won.connect(game_over)
	SignalBus.game_paused.connect(game_paused)

func game_started(start_game:bool):
	if start_game:
		game_state = GameState.RUNNING
	else:
		game_state = GameState.IDLE
	print("Game State: ", game_state)
	SignalBus.game_state.emit(game_state)

func game_over(game_over_flag:bool):
	if game_over_flag:
		game_state = GameState.ENDED
		game_score = 0
		print("GAMEOVER with Game State: ", game_state)
		SignalBus.game_state.emit(game_state)
 
func game_paused(game_over_flag:float):
	if game_over_flag:
		game_state = GameState.PAUSED
	else:
		game_state = GameState.RUNNING
	SignalBus.game_state.emit(game_state)

func _process(_delta):
	pass
