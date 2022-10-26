extends Node

export(int) var max_health_partner = 1 setget set_max_health_partner
var health_partner = max_health_partner setget set_health_partner

signal no_health_partner
signal health_changed(value)
signal max_health_changed(value)

func set_health_partner(value):
	health_partner = value
	emit_signal("health_changed", health_partner)
	if health_partner <= 0:
		emit_signal("no_health_partner")

func set_max_health_partner(value):
	max_health_partner = value
	self.health_partner = min(health_partner, max_health_partner)
	emit_signal("max_health_changed", max_health_partner)

func _ready():
	self.health_partner = max_health_partner
