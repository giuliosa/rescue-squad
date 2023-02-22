extends Node2D


func _ready():
	PlayerStats.max_health_player = 100
	PlayerStats.health_player = PlayerStats.max_health_player
	
	PlayerStats.max_stamina_player = 3
	PlayerStats.max_ammo_player = 6
	


func _on_Timer_timeout():
	get_tree().change_scene("res://Scenes/IntroScene.tscn")
