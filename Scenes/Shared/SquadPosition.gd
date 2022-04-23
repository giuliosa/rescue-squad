extends Node

export var squad_position = [] setget set_squad_position

func set_squad_position(value):
	squad_position.append(value)
	
func _ready():
	pass
