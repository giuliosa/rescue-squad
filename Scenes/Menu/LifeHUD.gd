extends CanvasLayer

onready var life := $Player/VBoxContainer/HBoxContainer/VBoxContainer/Life

func _ready():
	PlayerStats.max_health_player = life.max_value
	PlayerStats.health_player = PlayerStats.max_health_player
	
	pass
	
func _process(_delta):
	life.value = PlayerStats.health_player
	pass
	
