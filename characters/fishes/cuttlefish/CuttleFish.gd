extends FishResource
class_name CuttleFish

var fish_array: Array[Fish] = []
var fish_body: Node2D

func fish_init(body):
	fish_body = body
	for fish: Node2D in fish_body.get_tree().get_nodes_in_group("Fish"):
		var distance = (fish_body.position - fish.position).length()
		if distance < 100.0 and distance != 0 and fish.has_method("_toggle_visibility"):
			fish._toggle_visibility(false)
			fish_array.append(fish)

func on_collision(body):
	for fish in fish_array:
		if is_instance_valid(fish) and fish.has_method("_toggle_visibility"):
			fish._toggle_visibility(true)
