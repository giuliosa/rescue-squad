extends Node2D

const Squad = preload("res://Scenes/Actors/Squad.tscn")
const ExitDoor = preload("res://Scenes/ExitDoor.tscn")
const Monster = preload("res://Scenes/Actors/Enemies/Minions/Ciclope.tscn")

var borders = Rect2(1, 1, 97, 46)

onready var tileMap = $TileMap
onready var remoteTransform = $RemoteTransform2D

func _ready():
	randomize()
	generate_level()
	
func generate_level():
	var walker = Walker.new(Vector2(17, 10), borders)
	# Increase the number passed in the walk function to get bigger rooms
	var map = walker.walk(200)
	
	var squad = Squad.instance()
	for i in range(20):
		var monster = Monster.instance()
		add_child(monster)
		monster.position = walker.get_end_room().position * 32
	
		
	
	squad.add_child(remoteTransform)
	add_child(squad)
	squad.position = map.front() * 32
	
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
