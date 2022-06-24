extends KinematicBody2D

onready var hurtbox = $Hurtbox
onready var blinkAnimationPlayer = $BlinkAnimationPlayer

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
var player_role
var dead

func _physics_process(delta):
	if dead:
		$Body.visible = false
		$Gun.visible = false
		$Sprite.visible = false

func create_character(role):
	player_role = role
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

# func special_attack(direction):
# 	var special
	
# 	match role_name:
# 		CharacterClasses.Classes.SOLDIER:
# 			pass
			
# 		CharacterClasses.Classes.NANOTECH:
# 			special = IceAttack.instance()
			
# 		CharacterClasses.Classes.COMBAT_MEDIC:
# 			pass
			
# 		CharacterClasses.Classes.NINJA:
# 			pass

# 		CharacterClasses.Classes.MONK:
# 			pass

# 		CharacterClasses.Classes.SAMURAI:
# 			pass
	
# 	return special


func _on_Hurtbox_area_entered(area):
	var index = SquadPosition.position.find(player_role, 0)
	if SquadPosition.position[index].health > 0:
		SquadPosition.position[index].health -= area.damage
	if SquadPosition.position[index].health <= 0:
		dead = true
	hurtbox.start_invicibility(0.6)
	hurtbox.create_hit_effect()

func _on_Hurtbox_invicibility_ended():
	blinkAnimationPlayer.play("Stop")


func _on_Hurtbox_invicibility_started():
	blinkAnimationPlayer.play("Start")
