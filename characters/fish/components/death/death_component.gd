extends Node2D
class_name DeathComponent

@export var fish: Fish
@export var hitbox: Area2D
@export var score_component: ScoreComponent

func _ready():
	hitbox.body_entered.connect(destroy)

func destroy(body: Node2D):
	if fish.has_method("trigger_death_skill"):
		fish.trigger_death_skill(body)
	score_component.has_escaped = false
	fish.queue_free()
