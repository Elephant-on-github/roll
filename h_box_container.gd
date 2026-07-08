@tool # This tells Godot to run this script inside the editor viewport
extends HBoxContainer

func _ready():
	# Connect the resize events for all current slots
	_setup_connections()

func _notification(what):
	# This built-in function detects when nodes are added or moved in the editor
	if what == NOTIFICATION_CHILD_ORDER_CHANGED:
		_setup_connections()
		_update_all_sprites()

func _setup_connections():
	for slot in get_children():
		if slot is Control:
			# Disconnect first to avoid stacking duplicate connections in the editor
			if slot.item_rect_changed.is_connected(_center_sprite_in_slot):
				slot.item_rect_changed.disconnect(_center_sprite_in_slot)
				
			slot.item_rect_changed.connect(_center_sprite_in_slot.bind(slot))

func _update_all_sprites():
	for slot in get_children():
		if slot is Control:
			_center_sprite_in_slot(slot)

func _center_sprite_in_slot(slot: Control):
	for child in slot.get_children():
		if child is AnimatedSprite2D:
			child.position = slot.size / 2
