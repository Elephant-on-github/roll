extends Control
# helper functions for level and health

@onready var health = $texture/VBoxContainer/MarginContainer2/Health
@onready var level = $texture/VBoxContainer/MarginContainer3/level

var level_num :int
var health_num :int

func change_level(num : int) -> void:
	level_num = int(level.text) + num
	level.text = str(level_num)
	
func change_health(num : int) -> void:
	health_num = int(health.text) + num
	health.text = str(health_num)
	
func set_health_level(num1 : int, num2:int) -> void:
	health.text = str(num1)
	level.text = str(num2)
# Called when the node enters the scene tree for the first time.

func get_health() -> int:
	return int(health.text)
	
func get_level() -> int:
	return int(level.text)
