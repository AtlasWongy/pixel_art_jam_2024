extends Control

var fish_list_show_flag = false
var fish_info_show_flag = false

func _ready():
	self.visible = fish_list_show_flag
	
	var fishes_info = FileManager.fishes
	
	populate_fish_button(fishes_info)
	
	SignalBus.toggle_pause_menu_visibility.connect(toggle_self_visibility)
	
func populate_fish_button(fishes_info):
	for item in fishes_info:
		var button_text = " %s | %s " % [item.id, item.name]
		var fish_description = "%s \n\nPoints: %s" % [item.description, item.score]
		var icon_path = item.icon_path
		
		var fishInfoButton = $FishContainer/ScrollContainer/FishButtons/FishInfoButton
		var fishContainer = $FishContainer/ScrollContainer/FishButtons
		
		if item.id == "0":
			fishInfoButton.set_text(button_text)
			fishInfoButton.icon = load(icon_path) as Texture2D
			fishInfoButton.connect("pressed", Callable(self, "view_fish_info").bind(item.name, fish_description, icon_path))
			continue
		
		var button := Button.new()
		button.set_text_alignment(HORIZONTAL_ALIGNMENT_LEFT)
		button.set_text(button_text)
		
		var icon_texture = load(icon_path) as Texture2D
		if icon_texture:
			button.icon = icon_texture
			
		fishContainer.add_child(button)
		button.connect("pressed", Callable(self, "view_fish_info").bind(item.name, fish_description, icon_path))

func view_fish_info(fish_name:String, fish_description:String, icon_path:String):
		toggle_fish_list_visibility()
		toggle_fish_info_visibility(fish_name, fish_description, icon_path)
	
func toggle_fish_list_visibility():
	fish_list_show_flag = !fish_list_show_flag
	toggle_self_visibility(true)
	$FishContainer.visible = fish_list_show_flag
	$FishInfoContainer.visible = !fish_list_show_flag

func toggle_fish_info_visibility(fish_name:String, fish_description:String, icon_path:String):
	fish_info_show_flag = !fish_info_show_flag
	toggle_self_visibility(true)
	if fish_info_show_flag:
		$FishInfoContainer/NameLabel.set_text(fish_name)
		$FishInfoContainer/FishImage.icon = load(icon_path) as Texture2D
		$FishInfoContainer/DescriptionLabel.set_text(fish_description)
	$FishInfoContainer.visible = fish_info_show_flag
	
func toggle_self_visibility(show_pause_menu_flag:bool):
	if (!fish_info_show_flag && !fish_list_show_flag) || !show_pause_menu_flag:
		self.visible = false
	elif (fish_info_show_flag || fish_list_show_flag) && show_pause_menu_flag:
		self.visible = true
	
func _process(_delta):
	pass
