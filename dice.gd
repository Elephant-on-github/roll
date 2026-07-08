extends Control
signal is_rolled(total : int) 

@onready var dice_sprite = $texture/HBoxContainer/Control/Area2D/Die

var current_tween: Tween
var rolled = false

func roll_dice() -> int:
	var result = randi_range(1, 6)
	
	# Kill the previous tween if it's running
	if current_tween:
		current_tween.kill()
	
	current_tween = create_tween()
	current_tween.set_trans(Tween.TRANS_QUAD)
	current_tween.set_ease(Tween.EASE_OUT)
	
	# Spin rapidly
	current_tween.tween_property(dice_sprite, "rotation", TAU * 5, 0.5).as_relative()
	
	# After animation completes, set the final frame
	await current_tween.finished
	dice_sprite.frame = result - 1  # Frame indices are 0-5
	
	return result


func damage_or_defense() -> int:
	var number : int = 0 
	number = await roll_dice()
	is_rolled.emit(number)
	return number
	# wrapper to define special damage etc.
	

func reset_dice() -> void:
	rolled = false
	print("dice reset")

func _on_area_2d_clicked():
	if rolled:
		pass
	else:
		rolled = true
		await damage_or_defense()
