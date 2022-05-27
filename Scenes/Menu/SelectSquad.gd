extends Node2D

const CharacterStats = preload("res://Scenes/Menu/CharacterStats.tscn")
const combatMedic = preload("res://Resources/CombatMedic.tres")
const monk = preload("res://Resources/Monk.tres")
const nanotech = preload("res://Resources/Nanothechinician.tres")
const ninja = preload("res://Resources/Ninja.tres")
const samurai = preload("res://Resources/Samurai.tres")
const soldier = preload("res://Resources/Soldier.tres")

var all_characters = []
var button_control

func _ready():
	$Sprite2/MarginContainer/ColorRect/MarginContainer/VBoxContainer/SelectCharacter/CombatMedic.grab_focus()
	button_control = "CombatMedic"
	get_viewport().connect("gui_focus_changed", self, "_on_focus_changed")


func _process(delta):
	if Input.is_action_just_pressed("shoot_down"):
		match(button_control):
			"CombatMedic":
				var stats = CharacterStats.instance()
				$Sprite2/MarginContainer/ColorRect/MarginContainer/VBoxContainer.remove_child($Sprite2/MarginContainer/ColorRect/MarginContainer/VBoxContainer/ColorRect)
				$Sprite2/MarginContainer/ColorRect/MarginContainer/VBoxContainer.add_child(stats)
				stats.update_class_display(combatMedic)
			"Monk":
				var stats = CharacterStats.instance()
				$Sprite2/MarginContainer/ColorRect/MarginContainer/VBoxContainer.remove_child($Sprite2/MarginContainer/ColorRect/MarginContainer/VBoxContainer/ColorRect)
				$Sprite2/MarginContainer/ColorRect/MarginContainer/VBoxContainer.add_child(stats)
				stats.update_class_display(monk)
			"Nanothechinician":
				var stats = CharacterStats.instance()
				$Sprite2/MarginContainer/ColorRect/MarginContainer/VBoxContainer.remove_child($Sprite2/MarginContainer/ColorRect/MarginContainer/VBoxContainer/ColorRect)
				$Sprite2/MarginContainer/ColorRect/MarginContainer/VBoxContainer.add_child(stats)
				stats.update_class_display(nanotech)
			"Ninja":
				var stats = CharacterStats.instance()
				$Sprite2/MarginContainer/ColorRect/MarginContainer/VBoxContainer.remove_child($Sprite2/MarginContainer/ColorRect/MarginContainer/VBoxContainer/ColorRect)
				$Sprite2/MarginContainer/ColorRect/MarginContainer/VBoxContainer.add_child(stats)
				stats.update_class_display(ninja)
			"Samurai":
				var stats = CharacterStats.instance()
				$Sprite2/MarginContainer/ColorRect/MarginContainer/VBoxContainer.remove_child($Sprite2/MarginContainer/ColorRect/MarginContainer/VBoxContainer/ColorRect)
				$Sprite2/MarginContainer/ColorRect/MarginContainer/VBoxContainer.add_child(stats)
				stats.update_class_display(samurai)
			"Soldier":
				var stats = CharacterStats.instance()
				$Sprite2/MarginContainer/ColorRect/MarginContainer/VBoxContainer.remove_child($Sprite2/MarginContainer/ColorRect/MarginContainer/VBoxContainer/ColorRect)
				$Sprite2/MarginContainer/ColorRect/MarginContainer/VBoxContainer.add_child(stats)
				stats.update_class_display(soldier)
	
	if (SquadPosition.position.size() == 4):
		disable_all_buttons()
		
	for i in SquadPosition.position.size():
		match(i):
			0:
				$Sprite2/MarginContainer/ColorRect/MarginContainer/VBoxContainer/SelectedCharacters/First/Image.texture = SquadPosition.position[0].profile
				$Sprite2/MarginContainer/ColorRect/MarginContainer/VBoxContainer/SelectedCharacters/First/Name.text = SquadPosition.position[0].class_type
			1:
				$Sprite2/MarginContainer/ColorRect/MarginContainer/VBoxContainer/SelectedCharacters/Second/Image.texture = SquadPosition.position[1].profile
				$Sprite2/MarginContainer/ColorRect/MarginContainer/VBoxContainer/SelectedCharacters/Second/Name.text = SquadPosition.position[1].class_type
			2:
				$Sprite2/MarginContainer/ColorRect/MarginContainer/VBoxContainer/SelectedCharacters/Third/Image.texture = SquadPosition.position[2].profile
				$Sprite2/MarginContainer/ColorRect/MarginContainer/VBoxContainer/SelectedCharacters/Third/Name.text = SquadPosition.position[2].class_type
			3:
				$Sprite2/MarginContainer/ColorRect/MarginContainer/VBoxContainer/SelectedCharacters/Forth/Image.texture = SquadPosition.position[3].profile
				$Sprite2/MarginContainer/ColorRect/MarginContainer/VBoxContainer/SelectedCharacters/Forth/Name.text = SquadPosition.position[3].class_type
	
func _on_focus_changed(control:Control):
	if control != null:
		button_control = control.name

func _on_BackButton_pressed():
	get_tree().change_scene("res://Scenes/Menu/TitleScreen.tscn")


func _on_StartButton_pressed():
	get_tree().change_scene("res://Scenes/World.tscn")

func _on_CombatMedic_pressed():
	$Sprite2/MarginContainer/ColorRect/MarginContainer/VBoxContainer/SelectCharacter/CombatMedic.disabled = true
	$Sprite2/MarginContainer/ColorRect/MarginContainer/VBoxContainer/SelectCharacter/CombatMedic.texture_focused = null
	SquadPosition.position = combatMedic

func _on_Monk_pressed():
	$Sprite2/MarginContainer/ColorRect/MarginContainer/VBoxContainer/SelectCharacter/Monk.disabled = true
	$Sprite2/MarginContainer/ColorRect/MarginContainer/VBoxContainer/SelectCharacter/Monk.texture_focused = null
	SquadPosition.position = monk
	

func _on_Ninja_pressed():
	$Sprite2/MarginContainer/ColorRect/MarginContainer/VBoxContainer/SelectCharacter/Ninja.disabled = true
	$Sprite2/MarginContainer/ColorRect/MarginContainer/VBoxContainer/SelectCharacter/Ninja.texture_focused = null
	SquadPosition.position = ninja
	

func _on_Soldier_pressed():
	$Sprite2/MarginContainer/ColorRect/MarginContainer/VBoxContainer/SelectCharacter/Soldier.disabled = true
	$Sprite2/MarginContainer/ColorRect/MarginContainer/VBoxContainer/SelectCharacter/Soldier.texture_focused = null
	SquadPosition.position = soldier
	

func _on_Nanothechinician_pressed():
	$Sprite2/MarginContainer/ColorRect/MarginContainer/VBoxContainer/SelectCharacter/Nanothechinician.disabled = true
	$Sprite2/MarginContainer/ColorRect/MarginContainer/VBoxContainer/SelectCharacter/Nanothechinician.texture_focused = null
	SquadPosition.position = nanotech
	

func _on_Samurai_pressed():
	$Sprite2/MarginContainer/ColorRect/MarginContainer/VBoxContainer/SelectCharacter/Samurai.disabled = true
	$Sprite2/MarginContainer/ColorRect/MarginContainer/VBoxContainer/SelectCharacter/Samurai.texture_focused = null
	SquadPosition.position = samurai
	
func disable_all_buttons():
	$Sprite2/MarginContainer/ColorRect/MarginContainer/VBoxContainer/SelectCharacter/CombatMedic.disabled = true
	$Sprite2/MarginContainer/ColorRect/MarginContainer/VBoxContainer/SelectCharacter/CombatMedic.texture_focused = null
	$Sprite2/MarginContainer/ColorRect/MarginContainer/VBoxContainer/SelectCharacter/Monk.disabled = true
	$Sprite2/MarginContainer/ColorRect/MarginContainer/VBoxContainer/SelectCharacter/Monk.texture_focused = null
	$Sprite2/MarginContainer/ColorRect/MarginContainer/VBoxContainer/SelectCharacter/Ninja.disabled = true
	$Sprite2/MarginContainer/ColorRect/MarginContainer/VBoxContainer/SelectCharacter/Ninja.texture_focused = null
	$Sprite2/MarginContainer/ColorRect/MarginContainer/VBoxContainer/SelectCharacter/Soldier.disabled = true
	$Sprite2/MarginContainer/ColorRect/MarginContainer/VBoxContainer/SelectCharacter/Soldier.texture_focused = null
	$Sprite2/MarginContainer/ColorRect/MarginContainer/VBoxContainer/SelectCharacter/Nanothechinician.disabled = true
	$Sprite2/MarginContainer/ColorRect/MarginContainer/VBoxContainer/SelectCharacter/Nanothechinician.texture_focused = null
	$Sprite2/MarginContainer/ColorRect/MarginContainer/VBoxContainer/SelectCharacter/Samurai.disabled = true
	$Sprite2/MarginContainer/ColorRect/MarginContainer/VBoxContainer/SelectCharacter/Samurai.texture_focused = null

func add_character_to_selected_view():
	$Sprite2/MarginContainer/ColorRect/MarginContainer/VBoxContainer/SelectedCharacters/First/Image.texture = SquadPosition.position[0].profile
	$Sprite2/MarginContainer/ColorRect/MarginContainer/VBoxContainer/SelectedCharacters/First/Name.text = SquadPosition.position[0].class_type
