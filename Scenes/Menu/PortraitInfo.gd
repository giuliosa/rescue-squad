extends Control


func _process(delta):
	$Container/VBoxContainer/Top/FirstBox/Portrait.texture = SquadPosition.position[0].profile
	$Container/VBoxContainer/Top/FirstBox/Info/Life/LifeValue.text = String(SquadPosition.position[0].health)
	$Container/VBoxContainer/Top/FirstBox/Info/Mana/ManaValue.text = String(SquadPosition.position[0].mana)
	
	$Container/VBoxContainer/Top/SecondBox/Portrait.texture = SquadPosition.position[1].profile
	$Container/VBoxContainer/Top/SecondBox/Info/Life/LifeValue.text = String(SquadPosition.position[1].health)
	$Container/VBoxContainer/Top/SecondBox/Info/Mana/ManaValue.text = String(SquadPosition.position[1].mana)
	
	$Container/VBoxContainer/Bottom/ThirdBox/Portrait.texture = SquadPosition.position[2].profile
	$Container/VBoxContainer/Bottom/ThirdBox/Info/Life/LifeValue.text = String(SquadPosition.position[2].health)
	$Container/VBoxContainer/Bottom/ThirdBox/Info/Mana/ManaValue.text = String(SquadPosition.position[2].mana)
	
	$Container/VBoxContainer/Bottom/ForthBox/Portrait.texture = SquadPosition.position[3].profile
	$Container/VBoxContainer/Bottom/ForthBox/Info/Life/LifeValue.text = String(SquadPosition.position[3].health)
	$Container/VBoxContainer/Bottom/ForthBox/Info/Mana/ManaValue.text = String(SquadPosition.position[3].mana)
	

