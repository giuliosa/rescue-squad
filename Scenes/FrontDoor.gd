extends Node2D


func _ready():
	$ExitDoor.connect("leaving_level", self, "exit_door")

func exit_door():
	get_tree().change_scene("res://Scenes/World.tscn")
