extends Control

var fish_list_show_flag = false
var fish_info_show_flag = false

func _ready():
	self.visible = fish_list_show_flag
	
	var fishes_info = [
		{
			"id": "1",
			"name": "Tuna",
			"description": "The average fish. No abilities.",
			"score": "0"
		},
		{
			"id": "2",
			"name": "Rockfish",
			"description": "The solid one. Acts as a collider.",
			"score": "10"
		},	
		{
			"id": "3",
			"name": "Pufferfish",
			"description": "The spiky one. Explodes upon contact.",
			"score": "10"
		},
		{
			"id": "4",
			"name": "Glassfish",
			"description": "The random one. Deflects bubble at random angle.",
			"score": "10"
		},
		{
			"id": "5",
			"name": "Swordfish",
			"description": "The pointy one. Destroys ball when hit from front.",
			"score": "10"
		},
		{
			"id": "6",
			"name": "Cuttlefish",
			"description": "The hidden one. Camouflage surrounding fishes when hit for 2 shots.",
			"score": "10"
		},
		{
			"id": "7",
			"name": "Coral",
			"description": "The protective one. Provides a shield for surrounding fishes for 2 shots.",
			"score": "10"
		},
		{
			"id": "8",
			"name": "ZebraFish",
			"description": "The unusual one. Move 2 steps forward if no adjacent fishes were hit",
			"score": "10"
		}
	]
	populate_fish_button(fishes_info)
	
func populate_fish_button(fishes_info):
	for item in fishes_info:
		var button_text = " %s | %s " % [item.id, item.name]
		var fish_description = "%s \n\n Points: %s" % [item.description, item.score]
		
		var fishInfoButton = $FishContainer/ScrollContainer/FishButtons/FishInfoButton
		var fishInfoContainer = $FishContainer/ScrollContainer/FishButtons
		
		if item.id == "1":
			fishInfoButton.set_text(button_text)
			fishInfoButton.connect("pressed", Callable(self, "view_fish_info").bind(item.name, fish_description))
			continue
		
		var button := Button.new()
		button.set_text_alignment(0)
		button.set_text(button_text)
		
		fishInfoContainer.add_child(button)
		button.connect("pressed", Callable(self, "view_fish_info").bind(item.name, fish_description))

func view_fish_info(fish_name:String, fish_description:String):
	toggle_fish_list_visibility()
	toggle_fish_info_visibility(fish_name, fish_description)
	
func toggle_fish_list_visibility():
	fish_list_show_flag = !fish_list_show_flag
	toggle_self_visibility()
	$FishContainer.visible = fish_list_show_flag
	$FishInfoContainer.visible = !fish_list_show_flag

func toggle_fish_info_visibility(fish_name:String, fish_description:String):
	fish_info_show_flag = !fish_info_show_flag
	toggle_self_visibility()
	if fish_info_show_flag:
		$FishInfoContainer/NameLabel.set_text(fish_name)
		$FishInfoContainer/DescriptionLabel.set_text(fish_description)
	$FishInfoContainer.visible = fish_info_show_flag
	
func toggle_self_visibility():
	if !fish_info_show_flag && !fish_list_show_flag:
		self.visible = false
	elif fish_info_show_flag || fish_list_show_flag:
		self.visible = true
	
func _process(_delta):
	pass
