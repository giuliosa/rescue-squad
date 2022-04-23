extends ColorRect

onready var profile_image = get_node("MarginContainer/HBoxContainer/CenterContainer/TextureRect")
onready var class_label = get_node("MarginContainer/HBoxContainer/VBoxContainer/Class/Data")
onready var health_label = get_node("MarginContainer/HBoxContainer/VBoxContainer/Health/Data")
onready var mana_label = get_node("MarginContainer/HBoxContainer/VBoxContainer/Mana/Data")
onready var damage_label = get_node("MarginContainer/HBoxContainer/VBoxContainer/Damage/Data")
onready var armor_label = get_node("MarginContainer/HBoxContainer/VBoxContainer/Armor/Data")

func _ready():
	var class_data = load("res://Resources/CombatMedic.tres")
	update_class_display(class_data)
	
func update_class_display(class_data):
	profile_image.texture = class_data.profile
	class_label.text = class_data.class_type
	health_label.text = String(class_data.health)
	mana_label.text = String(class_data.mana)
	damage_label.text = String(class_data.damage)
	armor_label.text = String(class_data.armor)
	
