extends Node

export var position = [] setget set_position


func set_position(value):
	if (position.size() < 4):
		position.append(value)
	
func _ready():
	pass

func are_they_all_dead():
	var quantity = 0
	for i in position:
		if i.health == 0:
			quantity += 1
	
	if quantity == 4:
		return true

func revive_squad():
	position.clear()
