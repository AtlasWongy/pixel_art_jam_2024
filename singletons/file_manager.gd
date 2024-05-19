extends Node

var fishes = []

func _ready():
	load_json_file("res://characters/fishes/FishData.json")

# ----------------------------------------------------------
# Fish data file
func load_json_file(file_path: String):
	var file = FileAccess.open(file_path, FileAccess.READ)
	if file:
		var json = JSON.new()
		var json_content = file.get_as_text()
		var json_result = json.parse(json_content)
		if json_result == OK:
			var fish_content = json.data
			if typeof(fish_content["fishes"]) == TYPE_ARRAY:
				fishes = fish_content["fishes"]
			else:
				print("Unexpected data type found")
		else:
			print("JSON Parse Error: ", json.get_error_message(), " at line ", json.get_error_line())

func get_fish_description_by_name(fish_name: String) -> String:
	for fish in fishes:
		if fish["name"] == fish_name:
			return fish["description"]
	return "Fish not found."

func get_fish_score_by_name(fish_name: String) -> String:
	for fish in fishes:
		if fish["name"] == fish_name:
			return fish["score"]
	return "Fish not found."
	
func get_fish_score_by_id(fish_id: int) -> String:
	for fish in fishes:
		if fish["id"] == str(fish_id):
			return fish["score"]
	return "Fish not found."
	
# --------------------------------------------------------
# Highscore save file
func get_highscore() -> int:
	var score_file = FileAccess.open("user://highscoresave.data", FileAccess.READ)
	if score_file!=null:
		return score_file.get_32()
	else:
		return 0

		
func save_game():
	var save_file = FileAccess.open("user://highscoresave.data", FileAccess.WRITE)
	save_file.store_32(GameManager.high_score)
