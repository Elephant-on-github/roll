extends Button
signal add_defense

# Called when the node enters the scene tree for the first time.

func _on_pressed():
	add_defense.emit()
