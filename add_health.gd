extends Button
signal add_health

# Called when the node enters the scene tree for the first time.

func _on_pressed():
	add_health.emit()
