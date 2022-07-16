extends Control


func _ready():
	pass


func _on_OldVersion_pressed():
	get_tree().change_scene("res://Scenes/Menu/SelectSquad.tscn")


func _on_New_Verion_pressed():
	get_tree().change_scene("res://Scenes/Actors/Character.tscn")
