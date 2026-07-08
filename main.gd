extends Control
@onready var enemy = %Enemy
signal loss
signal prize
signal damage_oh_no

var health_modifier: int = 2
var attack_modifier: int = 2
var enemy_health_modifier: int = 2
var defense_modifier: int = 2  



func _ready():
	health_modifier = 2
	attack_modifier = 2
	enemy_health_modifier = 2
	defense_modifier = 2
	enemy.set_frame(0, false)
	%Info.set_health_level(20, 0)
	enemy.set_enemy_health(get_enemy_health_hybrid(%Info.get_level()))
	%status_atk_def.set_sword(true)
	%Dice_container.reset_dice()

func get_enemy_health_hybrid(level: int, scaling: float = 2.0) -> int:
	var base_health = 5
	var static_health = base_health + (level * scaling)
	var random_range = int(5 * level) + 5
	var random_roll = randi() % random_range
	return static_health + random_roll - enemy_health_modifier + 2

func _on_dice_container_is_rolled(total : int):
	enemy.damage(total + attack_modifier - 2)
	
	if enemy.get_enemy_health() <= 0:
		enemy.opp_defeated()
		
		# Trigger prize menu here if needed
		await get_tree().create_timer(0.75, false).timeout
		prize.emit()
		return
	else:
		# Wait for defense to fully finish its dice animation before returning to attack
		await get_tree().create_timer(0.75).timeout
		await defense()

func defense() -> void:
	%status_atk_def.set_sword(false)
	var damage_taken = await %Enemy_die.roll_dice() - defense_modifier + 2
	%Info.change_health(0 - damage_taken)
	damage_oh_no.emit()
	if %Info.get_health() <= 0:
		loss.emit()
		return
	else:
	# Pass the turn back to the player
		attack()

func attack() -> void:
	%status_atk_def.set_sword(true)
	%Dice_container.reset_dice()


func _on_handler_reward_claimed(type):
	print("Player claimed reward: ", type)
	match type:
		"attack":
			attack_modifier = attack_modifier ** 2
		"defense":
			defense_modifier = defense_modifier ** 2
		"health":
			health_modifier = health_modifier ** 2
		"enemy_health":
			enemy_health_modifier = enemy_health_modifier ** 2
		"none":
			print("Menu closed without picking a bonus.")
	var new_hp = get_enemy_health_hybrid(%Info.get_level()) 
	enemy.set_enemy_health(new_hp)
	%Info.set_health_level(20 + health_modifier - 2 + (%Info.get_level()), %Info.get_level())
	
	attack()
