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
	character_name = role.class_type
	role_name = role.class_type
	max_health = role.health
	max_mana = role.mana
	armor = role.armor
	attack = role.damage
	$Body.texture = role.animation
	$Gun.frame = role.weapon_frame
	return self

func attack(direction):
	var shoot 
	
	match role_name:
		'Infantry Soldier':
			shoot = Shoot.instance()
			shoot.get_node("ColorRect").frame = 1
			
		'Nanotechinician':
			shoot = Shoot.instance()
			shoot.get_node("ColorRect").frame = 2
			
		'Combat Medic':
			shoot = Shoot.instance()
			shoot.get_node("ColorRect").frame = 3

		'Samurai':
			shoot = Shoot.instance()
			shoot.get_node("ColorRect").frame = 4

		'Monk':
			shoot = Shoot.instance()
			shoot.get_node("ColorRect").frame = 5
			
		'Ninja':
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
		'Infantry Soldier':
			pass
			
		'Nanotechinician':
			special = IceAttack.instance()
			
		'Combat Medic':
			pass
			
		'Ninja':
			pass

		'Monk':
			pass

		'Samurai':
			pass
	
	return special
