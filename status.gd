extends Control
var sword = true

@onready var sword_node = $NinePatchRect/CenterContainer/Control2/Sword
@onready var shield_node = $NinePatchRect/CenterContainer/Control/Shield



# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _button_pressed() -> void:
	sword = !sword

func set_sword(sword_bool : bool) -> void:
	sword = sword_bool

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if sword:
		sword_node.visible = true
		shield_node.visible = false
	else:
		sword_node.visible = false
		shield_node.visible = true
