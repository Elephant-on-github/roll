extends AnimatedSprite2D

var current_tween: Tween
@onready var dice_sprite = self


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
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
