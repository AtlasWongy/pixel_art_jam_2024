extends Line2D

@onready var player_position = $".."

var viewport_size = get_viewport_rect().size

# Called when the node enters the scene tree for the first time.
func _ready():
	PackedVector2Array([player_position.x. player_position.y])
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func draw_line_indicator():
	pass
