extends Resource
class_name FishResource

@export var fish_sprite: Texture2D #this should be the fish's sprite path
@export var fish_value: int = 0
@export var has_shield: bool = false

func fish_init(body):
	pass

func fish_physics():
	pass

func on_collision(body):
	pass
	#this should be implemented by each individual fish resouce that extends this class

func add_shield():
	pass

