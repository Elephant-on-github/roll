extends Area2D
signal clicked

func _ready() -> void:
	# Make sure the area is actively listening for the mouse
	input_pickable = true

func _input_event(_viewport: Viewport, event: InputEvent, _shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		_on_sprite_clicked()

func _on_sprite_clicked() -> void:
	print("Sprite clicked!")
	clicked.emit()
 

func _on_mouse_entered():
	Input.set_default_cursor_shape(Input.CURSOR_POINTING_HAND)
	print("ello")


func _on_mouse_exited():
	Input.set_default_cursor_shape(Input.CURSOR_ARROW)
	print("bye")
