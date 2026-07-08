extends Control

@onready var blur_background = $BlurBackground
@onready var loss_overlay = self
@onready var replay_button = $CenterPositioner/MiniWindow/TextPadding/ReplayButon

func _ready():
	loss_overlay.visible = false
	loss_overlay.modulate.a = 0.0
	if blur_background.material:
		blur_background.material.set_shader_parameter("blur_amount", 0.0)
	
func _on_start_pressed():
	get_tree().change_scene_to_file("res://main.tscn")

func _on_process_loss():
	loss_overlay.visible = true
	
	var tween = create_tween().set_parallel(true)
	tween.tween_property(loss_overlay, "modulate:a", 1.0, 0.3).set_trans(Tween.TRANS_SINE)
	if blur_background.material:
		tween.tween_property(blur_background.material, "shader_parameter/blur_amount", 4.0, 0.3).set_trans(Tween.TRANS_SINE)

func _on_replay_buton_pressed():
	var tween = create_tween().set_parallel(true)
	tween.tween_property(loss_overlay, "modulate:a", 0.0, 0.2).set_trans(Tween.TRANS_SINE)
	if blur_background.material:
		tween.tween_property(blur_background.material, "shader_parameter/blur_amount", 0.0, 0.2).set_trans(Tween.TRANS_SINE)
	
	tween.chain().tween_callback(func(): loss_overlay.visible = false)
	%Process._ready()

func _unhandled_input(event: InputEvent) -> void:
	# Catch the Escape key to close the menu if it's currently open
	if event.is_action_pressed("ui_cancel") and loss_overlay.visible:
		_on_replay_buton_pressed()
