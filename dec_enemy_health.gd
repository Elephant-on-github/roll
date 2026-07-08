extends Button
signal dec_enemy_health

# Called when the node enters the scene tree for the first time.

func _on_pressed():
	dec_enemy_health.emit()
