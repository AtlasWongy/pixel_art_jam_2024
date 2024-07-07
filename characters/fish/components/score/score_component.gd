extends Node2D
class_name ScoreComponent

@export_category("Score Points")
@export var score: int

var has_escaped: bool = true

func _exit_tree():
	if !has_escaped:
		SignalBus.on_score.emit(score)
