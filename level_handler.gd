extends Node2D

# 1. Define the signal that your main game node will listen to
signal reward_claimed(type: String)

const PRIZE_MENU_SCENE = preload("res://Prize_menu.tscn") 

func open_prize_menu():
	get_tree().paused = true 
	
	var blur_overlay = ColorRect.new() 
	blur_overlay.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT) 
	blur_overlay.size = get_viewport_rect().size 
	blur_overlay.z_index = 9 
	blur_overlay.process_mode = Node.PROCESS_MODE_ALWAYS 
	
	var shader_material = ShaderMaterial.new() 
	shader_material.shader = preload("res://blur.gdshader") 
	blur_overlay.material = shader_material 
	
	add_child(blur_overlay) 
	
	var prize_menu_instance = PRIZE_MENU_SCENE.instantiate() 
	prize_menu_instance.z_index = 10 
	prize_menu_instance.process_mode = Node.PROCESS_MODE_ALWAYS 
	
	# 2. Connect the menu instance's signal to a local forwarding function
	prize_menu_instance.prize_selected.connect(_on_menu_prize_selected)
	
	var screen_center = get_viewport_rect().size / 2 
	prize_menu_instance.global_position = screen_center 
	
	add_child(prize_menu_instance) 

# 3. This function catches the signal from the menu and passes it up to the main scene
func _on_menu_prize_selected(prize_type: String):
	reward_claimed.emit(prize_type)
	# Do not call queue_free() here if level_handler needs to persist!
	
func close_prize_menu():
	get_tree().paused = false 
	
	var main_scene = get_parent() 
	for child in main_scene.get_children(): 
		if child is ColorRect and child.material and child.material.shader: 
			child.queue_free() 
			
	queue_free()


func _on_process_prize():
	open_prize_menu()
