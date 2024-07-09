extends Node

var current_scene: Node = null

func _ready():
	var root: Window = get_tree().root
	current_scene = root.get_child(root.get_child_count() - 1)
	
func goto_scene(path):
	call_deferred("_deferred_goto_scene", path)
	
##func _deffered_goto_scene(path):
	##current_scene.free()
	##var s: Resource = ResourceLoader.load(path)
	##current_scene = s.instantiate()
	##get_tree().root.add_child(current_scene)
	##get_tree().current_scene = current_scene
func _deferred_goto_scene(packedScene: PackedScene):
	current_scene.free()
	current_scene = packedScene.instantiate()
	get_tree().root.add_child(current_scene)
	get_tree().current_scene = current_scene
