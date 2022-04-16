extends Node2D


func _ready():
	$Sprite/MarginContainer/VBoxContainer/VBoxContainer/StartButton.grab_focus()

func _physics_process(delta):
	pass

func _on_StartButton_pressed():
	print("Start")
	get_tree().change_scene("res://Scenes/SelectSquad.tscn")


func _on_ExitButton_pressed():
	print("Exit")
	get_tree().quit()
