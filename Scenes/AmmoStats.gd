extends Node

export(int) var max_ammo = 1 setget set_max_ammo
var ammo = max_ammo setget set_ammo

signal no_ammo
signal ammo_changed(value)
signal max_ammo_changed(value)

func set_ammo(value):
	ammo = value
	emit_signal("ammo_changed", ammo)
	if ammo <= 0:
		emit_signal("no_ammo")

func set_max_ammo(value):
	max_ammo = value
	self.ammo = min(ammo, max_ammo)
	emit_signal("max_ammo_changed", max_ammo)

func _ready():
	self.ammo = max_ammo
