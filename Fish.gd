extends Node2D

@export var fish_resource:FishResource

# Called when the node enters the scene tree for the first time.
func _ready():
	if fish_resource:
		fish_resource.on_collision() #this is just for testing. remove later.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
