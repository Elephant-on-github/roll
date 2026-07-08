extends Button
signal add_attack

# Called when the node enters the scene tree for the first time.

func _on_pressed():
	add_attack.emit()
