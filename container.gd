extends VBoxContainer

@export var hover_scale : Vector2 = Vector2(1.2, 1.2)
@export var normal_scale : Vector2 = Vector2(1.0, 1.0)
@export var animation_duration : float = 0.15

func _ready():
	for child in get_children():
		if child is TextureRect:
			child.mouse_filter = Control.MOUSE_FILTER_STOP
			child.z_as_relative = false
			child.z_index = 0
			
			# FIX: Whenever the layout engine resizes the child, calculate the correct center point
			child.item_rect_changed.connect(func(): child.pivot_offset = child.size / 2)
			
			child.mouse_entered.connect(_on_child_hovered.bind(child))
			child.mouse_exited.connect(_on_child_unhovered.bind(child))

func _on_child_hovered(child: TextureRect):
	child.z_index = 5
	var tween = create_tween().set_parallel(true)
	tween.tween_property(child, "scale", hover_scale, animation_duration).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)

func _on_child_unhovered(child: TextureRect):
	child.z_index = 0
	var tween = create_tween().set_parallel(true)
	tween.tween_property(child, "scale", normal_scale, animation_duration).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
