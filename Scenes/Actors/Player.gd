extends KinematicBody2D

export(String) var character_name = ""
export(String) var role_name = ""
export(int) var max_health = 1
export(int) var max_mana = 1
export(int) var armor = 1

func create_character(role):
	match role:
		'soldier':
			character_name = "Soldier"
			role_name = "Solider"
			max_health = 3
			max_mana = 2
			armor = 3
			$Body.texture = load("res://Assets/Actor/Characters/Villager2/SpriteSheet.png")
			$Gun.frame = 1
			return self
			
		'nanotechinician':
			character_name = "nanotechinician"
			role_name = "nanotechinician"
			max_health = 3
			max_mana = 2
			armor = 3
			$Body.texture = load("res://Assets/Actor/Characters/Eskimo/SpriteSheet.png")
			$Gun.frame = 2
			return self
			
		'combat_medic':
			character_name = "combat_medic"
			role_name = "combat_medic"
			max_health = 3
			max_mana = 2
			armor = 3
			$Body.texture = load("res://Assets/Actor/Characters/MaskFrog/SpriteSheet.png")
			$Gun.frame = 3
			return self
			
		'ninja':
			character_name = "ninja"
			role_name = "ninja"
			max_health = 3
			max_mana = 2
			armor = 3
			$Body.texture = load("res://Assets/Actor/Characters/RedNinja/SpriteSheet.png")
			$Gun.frame = 4
			return self
