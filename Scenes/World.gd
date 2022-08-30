extends Node2D

const Character = preload("res://Scenes/Actors/Character.tscn")
const Partner = preload("res://Scenes/Actors/Partner.tscn")
const ExitDoor = preload("res://Scenes/ExitDoor.tscn")
const Monster = preload("res://Scenes/Actors/Enemies/Minions/Ciclope.tscn")

var borders = Rect2(1, 1, 97, 46)

onready var tileMap = $NavigationObstacle2D/TileMap
onready var remoteTransform = $RemoteTransform2D

func _ready():
	randomize()
	generate_level()
	
func _process(_delta):
	if Input.is_action_pressed("ui_cancel"):
		get_tree().quit()
	
func generate_level():
	var walker = Walker.new(Vector2(17, 10), borders)
	# Increase the number passed in the walk function to get bigger rooms
	var map = walker.walk(200)
	
	var squad = Character.instance()
	var partner = Partner.instance()
	var room_index = 0
	for room in walker.rooms:
		room_index += 1
		var monster = Monster.instance()
		if room_index > 5:
			add_child(monster)
		monster.position = room.position * 32
		
	
	squad.add_child(remoteTransform)
	add_child(squad)
	add_child(partner)
	squad.position = map.front() * 32
	partner.position = map.front() * 32
	
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
