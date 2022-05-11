extends Node

export var position = [] setget set_position

func set_position(value):
	if (position.size() < 4):
		position.append(value)
	
func _ready():
	pass
