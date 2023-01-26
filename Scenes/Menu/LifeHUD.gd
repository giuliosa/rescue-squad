extends CanvasLayer

onready var life := $Player/VBoxContainer/HBoxContainer/VBoxContainer/Life
onready var ammoTotal := $Player/VBoxContainer/AmmoContainer/AmmoTotal
onready var power := $Player/VBoxContainer/HBoxContainer/VBoxContainer/Power

func _ready():
	PlayerStats.max_health_player = life.max_value
	PlayerStats.health_player = PlayerStats.max_health_player
	
	PlayerStats.max_stamina_player = power.max_value
	
func _process(_delta):
	life.value = PlayerStats.health_player
	
	power.value = PlayerStats.stamina_player
	
	ammoTotal.text = String(AmmoStats.max_ammo)
	
