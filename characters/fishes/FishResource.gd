extends Resource
class_name FishResource

@export var fish_sprite: Texture2D #this should be the fish's sprite path
@export var fish_value: int = 0

func on_collision(_body):
	pass
	#this should be implemented by each individual fish resouce that extends this class

