extends Control

@onready var sprite = %opponent
@onready var smoke = %smoke
@onready var enemy_health_num = %Enemy_health
@onready var enemy_name = %Enemy_name
@onready var round = $NinePatchRect/round

signal levelup

# schema : [{frame, name, defeated}, ...]
var characters: Array = [
	{"frame": 0, "name": "Gary", "defeated": 0},
	{"frame": 1, "name": "Rob", "defeated": 0},
	{"frame": 2, "name": "Beth", "defeated": 0},
	{"frame": 3, "name": "Amoonda", "defeated": 0},
	{"frame": 4, "name": "Bryani", "defeated": 0},
	{"frame": 5, "name": "Julienne", "defeated": 0},
	{"frame": 6, "name": "Dwight", "defeated": 0},
	{"frame": 7, "name": "Tom", "defeated": 0},
	{"frame": 8, "name": "Phil", "defeated": 0},
]

var smoke_time = 0.1

func set_frame(num : int, transition : bool) -> void:
	sprite.frame = num
	enemy_name.text = characters[sprite.frame]["name"]
	if transition:
		smoke_animation()

func smoke_animation() -> void:
	smoke.visible = true
	smoke.frame = 0
	await get_tree().create_timer(smoke_time).timeout
	smoke.frame = 1
	await get_tree().create_timer(smoke_time).timeout
	smoke.frame = 2
	await get_tree().create_timer(smoke_time).timeout
	smoke.frame = 3
	await get_tree().create_timer(smoke_time).timeout
	smoke.visible = false

func opp_defeated() -> void:
	characters[sprite.frame]["defeated"] += 1 
	print(characters)
	%Info.change_level(1)
	var next_frame = sprite.frame + 1
	if next_frame >= characters.size():
		print("Defeated everyone! Looping back to the first character.")
		sprite.frame = 0 # Loop back to Gary
		round.visible = true
	else:
		sprite.frame = next_frame
	enemy_name.text = characters[sprite.frame]["name"]
	round.text = "(" + str(characters[sprite.frame]["defeated"]+1) + ")" 
	smoke_animation()

func set_enemy_health(num : int) -> void:
	enemy_health_num.text = str(num)

func get_enemy_health() -> int:
	return int(enemy_health_num.text)
	
func change_enemy_health(num : int) -> void:
	enemy_health_num.text = str(int(enemy_health_num.text) + num)


#func enemy_health(level, scaling) -> int:
	#var health = 0
	#var modifier = scaling * level
	#health = randi() % 20 * modifier
	#return health

func damage(num:int) -> void:
	change_enemy_health(0 - num)
	flash_red()

func flash_red() -> void:
	# Safety check to ensure the sprite exists
	if not sprite: 
		return
		
	# Create a fresh tween instance
	var tween = create_tween()
	
	# Step 1: Immediately shift the sprite's tint to solid red over 0.05 seconds
	tween.tween_property(sprite, "modulate", Color(2, 0.4, 0.4, 1), 0.05)
	
	# Step 2: Fade the tint back to its normal original color over 0.15 seconds
	tween.tween_property(sprite, "modulate", Color(1, 1, 1, 1), 0.15)

# Called when the node enters the scene tree for the first time.
func _ready():
	smoke.visible = false
	round.visible = false
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
