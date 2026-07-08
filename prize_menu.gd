extends Control
# prize menu

# 1. Define the custom signal at the very top
signal prize_selected(type: String)

@onready var close_button = $UI_Container/NinePatchRect/MarginContainer/MarginContainer/Button 

func _ready():
	close_button.pressed.connect(func(): _on_prize_chosen("none")) 

# Helper function to emit the choice and clean up the menu
func _on_prize_chosen(prize_type: String):
	prize_selected.emit(prize_type)
	close_prize_menu()

func close_prize_menu():
	get_tree().paused = false 
	
	# Clean up blur overlays on the parent
	var main_scene = get_parent() 
	for child in main_scene.get_children(): 
		if child is ColorRect and child.material and child.material.shader: 
			child.queue_free() 
			
	queue_free() 

# Update your button functions to pass their respective prize types
func _on_button_2_add_attack():
	_on_prize_chosen("attack")

func _on_button_3_add_defense():
	_on_prize_chosen("defense")

func _on_button_4_add_health():
	_on_prize_chosen("health")

func _on_button_5_dec_enemy_health():
	_on_prize_chosen("enemy_health")
