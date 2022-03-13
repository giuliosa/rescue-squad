extends Node2D

const Player = preload("res://Scenes/Player.tscn")
const Party = preload("res://Scenes/Party.tscn")
const ExitDoor = preload("res://Scenes/ExitDoor.tscn")

var borders = Rect2(1, 1, 38, 20)

onready var tileMap = $TileMap

func _ready():
	randomize()
	generate_level()
	
func generate_level():
	var walker = Walker.new(Vector2(17, 10), borders)
	# Increase the number passed in the walk function to get bigger rooms
	var map = walker.walk(500)
	
	var party = Party.instance()
	add_child(party)
	party.position = map.front() * 32
	
	var exitDoor = ExitDoor.instance()
	add_child(exitDoor)
	exitDoor.position = walker.get_end_room().position * 32
	exitDoor.connect("leaving_level", self, "reload_level")
	
	walker.queue_free()
	for location in map:
		tileMap.set_cellv(location, -1)
	tileMap.update_bitmask_region(borders.position, borders.end)

func reload_level():
	get_tree().reload_current_scene()

func _input(event):
	if event.is_action_pressed("ui_accept"):
		reload_level()
