extends Node

enum GameState {IDLE, RUNNING, ENDED, PAUSED}

var game_state
var game_score = 0
var high_score

func _ready():
	game_state = GameState.IDLE
	print("Game State: ", game_state)
	
	get_highscore()
	
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
		
		FileManager.save_game()
		
		game_score = 0
		print("GAMEOVER with Game State: ", game_state)
		SignalBus.game_state.emit(game_state)
 
func game_paused(game_over_flag:float):
	if game_over_flag:
		game_state = GameState.PAUSED
	else:
		game_state = GameState.RUNNING
	SignalBus.game_state.emit(game_state)

func get_highscore():
	high_score = FileManager.get_highscore()
	FileManager.save_game()
	print("HighScore: ", high_score)
	SignalBus.update_highscore.emit(high_score)
	
func get_current_score(current_score:int):
	game_score = current_score
	update_high_score()
	
func update_high_score():
	if game_score > high_score:
		high_score = game_score
		FileManager.save_game()
	SignalBus.update_highscore.emit(high_score)

func _process(_delta):
	pass
