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
		CharacterClasses.Classes.SOLDIER:
			shoot = Shoot.instance()
			shoot.get_node("ColorRect").frame = 1
			
		CharacterClasses.Classes.NANOTECH:
			shoot = Shoot.instance()
			shoot.get_node("ColorRect").frame = 2
			
		CharacterClasses.Classes.COMBAT_MEDIC:
			shoot = Shoot.instance()
			shoot.get_node("ColorRect").frame = 3

		CharacterClasses.Classes.SAMURAI:
			shoot = Shoot.instance()
			shoot.get_node("ColorRect").frame = 4

		CharacterClasses.Classes.MONK:
			shoot = Shoot.instance()
			shoot.get_node("ColorRect").frame = 5
			
		CharacterClasses.Classes.NINJA:
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
		CharacterClasses.Classes.SOLDIER:
			pass
			
		CharacterClasses.Classes.NANOTECH:
			special = IceAttack.instance()
			
		CharacterClasses.Classes.COMBAT_MEDIC:
			pass
			
		CharacterClasses.Classes.NINJA:
			pass

		CharacterClasses.Classes.MONK:
			pass

		CharacterClasses.Classes.SAMURAI:
			pass
	
	return special
