extends Control

@onready var start_button = $VBoxContainer/MarginContainer/start
@onready var blur_background = $CreditsOverlay/BlurBackground
@onready var credits_overlay = $CreditsOverlay

func _ready():
	start_button.pressed.connect(_on_start_pressed)
	credits_overlay.visible = false
	credits_overlay.modulate.a = 0.0
	if blur_background.material:
		blur_background.material.set_shader_parameter("blur_amount", 0.0)
	
func _on_start_pressed():
	get_tree().change_scene_to_file("res://main.tscn")

func _on_credits_button_pressed() -> void:
	credits_overlay.visible = true
	
	var tween = create_tween().set_parallel(true)
	tween.tween_property(credits_overlay, "modulate:a", 1.0, 0.3).set_trans(Tween.TRANS_SINE)
	if blur_background.material:
		tween.tween_property(blur_background.material, "shader_parameter/blur_amount", 4.0, 0.3).set_trans(Tween.TRANS_SINE)

func _on_back_buton_pressed():
	var tween = create_tween().set_parallel(true)
	tween.tween_property(credits_overlay, "modulate:a", 0.0, 0.2).set_trans(Tween.TRANS_SINE)
	if blur_background.material:
		tween.tween_property(blur_background.material, "shader_parameter/blur_amount", 0.0, 0.2).set_trans(Tween.TRANS_SINE)
	
	tween.chain().tween_callback(func(): credits_overlay.visible = false)

func _on_credits_text_meta_clicked(meta: Variant) -> void:
	OS.shell_open(str(meta))
	
func _unhandled_input(event: InputEvent) -> void:
	# Catch the Escape key to close the menu if it's currently open
	if event.is_action_pressed("ui_cancel") and credits_overlay.visible:
		_on_back_buton_pressed()


func _on_credits_overlay_gui_input(event):
		# Catch any mouse click that lands outside the mini-window boundaries
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		_on_back_buton_pressed()
