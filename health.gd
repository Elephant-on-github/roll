extends Label


# Called when the node enters the scene tree for the first time.
func red():
	# Safety check to ensure the sprite exists
	if not self: 
		return
		
	# Create a fresh tween instance
	var tween = create_tween()
	
	# Step 1: Immediately shift the sprite's tint to solid red over 0.05 seconds
	tween.tween_property(self, "modulate", Color(2, 0.4, 0.4, 1), 0.05)
	
	# Step 2: Fade the tint back to its normal original color over 0.15 seconds
	tween.tween_property(self, "modulate", Color(1, 1, 1, 1), 0.15)
	
	


func _on_process_damage_oh_no():
	red()# Replace with function body.
