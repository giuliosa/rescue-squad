extends KinematicBody2D
const Player = preload("res://Scenes/Player.tscn")

const position1 = Vector2(16, 0)
const position2 = Vector2(16, 16)
const position3 = Vector2(-16, 16)
const position4 = Vector2(0, 32)

onready var player1 = $Player
onready var player2 = $Player2
onready var player3 = $Player3
onready var player4 = $Player4

var player_position = []

func _ready():
	player_position.append(player1)
	player_position.append(player2)
	player_position.append(player3)
	player_position.append(player4)
	fix_look_direction()

func _physics_process(_delta):
	var x_input = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	var y_input = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	move_and_slide(Vector2(x_input, y_input) * 100)
	
	if Input.is_action_just_pressed("change_right"):
		change_array_position("right")
	if Input.is_action_just_pressed("change_left"):
		change_array_position("left")


func change_array_position(direction):
	if direction == "right":
		var last = player_position.pop_back()
		player_position.push_front(last)
		move_to_right()
		
	elif direction == "left":
		var last = player_position.pop_front()
		player_position.push_back(last)
		move_to_left()

func move_to_right():
	player_position[0].move_and_slide(Vector2(16, 0) * 60)
	player_position[1].move_and_slide(Vector2(0, 16) * 60)
	player_position[2].move_and_slide(Vector2(-16, 0) * 60)
	player_position[3].move_and_slide(Vector2(0, -16) * 60)
	fix_look_direction()

func move_to_left():
	player_position[0].move_and_slide(Vector2(0, -16) * 60)
	player_position[1].move_and_slide(Vector2(16, 0) * 60)
	player_position[2].move_and_slide(Vector2(0, 16) * 60)
	player_position[3].move_and_slide(Vector2(-16, 0) * 60)
	fix_look_direction()

func fix_look_direction():
	player_position[0].get_node("AnimationPlayer").play("look_right")
	player_position[1].get_node("AnimationPlayer").play("look_down")
	player_position[2].get_node("AnimationPlayer").play("look_left")
	player_position[3].get_node("AnimationPlayer").play("look_up")
