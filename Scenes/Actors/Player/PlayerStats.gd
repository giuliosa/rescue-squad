extends Node

export(int) var max_health_player = 1 setget set_max_health_player
var health_player = max_health_player setget set_health_player

export(int) var max_stamina_player = 1 setget set_max_stamina_player
var stamina_player = max_stamina_player setget set_stamina_player

signal no_health_player
signal health_changed(value)
signal max_health_changed(value)

signal no_stamina_player
signal stamina_changed(value)
signal max_stamina_changed(value)

func set_health_player(value):
	health_player = value
	emit_signal("health_changed", health_player)
	if health_player <= 0:
		emit_signal("no_health_player")

func set_max_health_player(value):
	max_health_player = value
	self.health_player = min(health_player, max_health_player)
	emit_signal("max_health_changed", max_health_player)

func set_stamina_player(value):
	stamina_player = value
	emit_signal("stamina_changed", stamina_player)
	if stamina_player <= 0:
		emit_signal("no_stamina_player")

func set_max_stamina_player(value):
	max_stamina_player = value
	self.stamina_player = min(stamina_player, max_stamina_player)
	emit_signal("max_stamina_changed", max_stamina_player)
	


func _ready():
	self.health_player = max_health_player
