extends Node2D


func _ready():
	$Sprite/MarginContainer/VBoxContainer/VBoxContainer/StartButton.grab_focus()

func _physics_process(delta):
	pass

func _on_StartButton_pressed():
	get_tree().change_scene("res://Scenes/Menu/ChooseVersion.tscn")


func _on_ExitButton_pressed():
	get_tree().quit()
