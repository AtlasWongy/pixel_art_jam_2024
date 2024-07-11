extends Node

var is_game_paused: bool

func _ready() -> void:
	is_game_paused = false
	
func _process(delta: float) -> void:
	pass
	#if Input.is_action_just_pressed("pause"):
		#toggle_game_pause()
		#SignalBus.on_game_pause.emit(is_game_paused)
		
func toggle_game_pause() -> void:
	is_game_paused = !is_game_paused
	get_tree().paused = is_game_paused 

