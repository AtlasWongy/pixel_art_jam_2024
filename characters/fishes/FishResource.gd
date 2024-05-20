extends Resource
class_name FishResource

@export var fish_sprite: Texture2D #this should be the fish's sprite path
@export var fish_value: int = 0
@export var has_shield: bool = false
@export var move_foward_flag: bool = false
@export var no_fish_infront_flag: bool = false

func on_collision(_body):
	pass
	#this should be implemented by each individual fish resouce that extends this class

