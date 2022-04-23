extends KinematicBody2D

const Shoot = preload("res://Scenes/Shoot.tscn")
const Sword = preload("res://Scenes/Effects/Attacks/Sword.tscn")
const Shuriken = preload("res://Scenes/Effects/Attacks/Shots/shuriken.tscn")
const IceAttack = preload("res://Scenes/Effects/Attacks/Special/ice.tscn")


export(String) var character_name = ""
export(String) var role_name = ""
export(int) var max_health = 1
export(int) var max_mana = 1
export(int) var armor = 1
var attack

func create_character(role):
	match role:
		'soldier':
			character_name = "soldier"
			role_name = "soldier"
			max_health = 3
			max_mana = 2
			armor = 3
			attack = 3
			$Body.texture = load("res://Assets/Actor/Characters/Villager2/SpriteSheet.png")
			$Gun.frame = 1
			return self
			
		'nanotechinician':
			character_name = "nanotechinician"
			role_name = "nanotechinician"
			max_health = 3
			max_mana = 2
			armor = 3
			attack = 2
			$Body.texture = load("res://Assets/Actor/Characters/Eskimo/SpriteSheet.png")
			$Gun.frame = 2
			return self
			
		'combat_medic':
			character_name = "combat_medic"
			role_name = "combat_medic"
			max_health = 3
			max_mana = 2
			armor = 3
			attack = 1
			$Body.texture = load("res://Assets/Actor/Characters/MaskFrog/SpriteSheet.png")
			$Gun.frame = 3
			return self
			
		'ninja':
			character_name = "ninja"
			role_name = "ninja"
			max_health = 3
			max_mana = 2
			armor = 3
			attack = 4
			$Body.texture = load("res://Assets/Actor/Characters/RedNinja/SpriteSheet.png")
			$Gun.frame = 4
			return self

func attack(direction):
	var shoot 
	
	match role_name:
		'soldier':
			shoot = Shoot.instance()
			shoot.get_node("ColorRect").frame = 1
			
		'nanotechinician':
			shoot = Shoot.instance()
			shoot.get_node("ColorRect").frame = 2
			
		'combat_medic':
			shoot = Shoot.instance()
			shoot.get_node("ColorRect").frame = 3
			
		'ninja':
			shoot = Shuriken.instance()
	
	shoot.shoot_type = role_name
	shoot.damage = attack
			
	if direction == "right":		
		shoot.set_shoot_direction(1, 0)
		
	elif direction == "left":
		shoot.set_shoot_direction(-1, 0)
		
	elif direction == "up":
		shoot.set_shoot_direction(0, -1)
		
	elif direction == "down":
		shoot.set_shoot_direction(0, 1)
		
	return shoot

func special_attack(direction):
	var special
	
	match role_name:
		'soldier':
			pass
			
		'nanotechinician':
			special = IceAttack.instance()
			
		'combat_medic':
			pass
			
		'ninja':
			pass
	
	return special