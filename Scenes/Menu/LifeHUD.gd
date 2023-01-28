extends CanvasLayer

onready var life := $Player/VBoxContainer/HBoxContainer/VBoxContainer/Life
onready var power := $Player/VBoxContainer/HBoxContainer/VBoxContainer/Power
onready var ammo := $Player/VBoxContainer/HBoxContainer/VBoxContainer/Ammo

func _ready():
	PlayerStats.max_health_player = life.max_value
	PlayerStats.health_player = PlayerStats.max_health_player
	
	PlayerStats.max_stamina_player = power.max_value
	PlayerStats.max_ammo_player = ammo.max_value
	
func _process(_delta):
	life.value = PlayerStats.health_player
	
	power.value = PlayerStats.stamina_player
	
	ammo.value = PlayerStats.ammo_player
	
	
