extends KinematicBody2D

const Player = preload("res://Scenes/Player.tscn")
const Shoot = preload("res://Scenes/Shoot.tscn")

const position1 = Vector2(16, 0)
const position2 = Vector2(16, 16)
const position3 = Vector2(-16, 16)
const position4 = Vector2(0, 32)

const ACCELERATION = 600
const MAX_SPEED = 120
const FRICTION = 400

var velocity = Vector2.ZERO

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

func _physics_process(delta):
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input_vector = input_vector.normalized()
		
	if input_vector != Vector2.ZERO:
		velocity = velocity.move_toward(input_vector * MAX_SPEED, ACCELERATION * delta)
	else:
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
	velocity = move_and_slide(velocity)
	
	if Input.is_action_just_pressed("change_right"):
		#change_array_position("right")
		pass
	if Input.is_action_just_pressed("change_left"):
		#change_array_position("left")
		pass
		
	
	if Input.is_action_pressed("shoot_right"):
		player_shoot($ShootPositionRight, "right")
	if Input.is_action_just_pressed("shoot_up"):
		player_shoot($ShootPositionUp, "up")
	if Input.is_action_just_pressed("shoot_left"):
		player_shoot($ShootPositionLeft, "left")
	if Input.is_action_just_pressed("shoot_down"):
		player_shoot($ShootPositionDown, "down")

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

func player_shoot(shoot_position, direction):
	var shoot = Shoot.instance()
	if direction == "right":
		shoot.set_shoot_direction(1, 0)
	elif direction == "left":
		shoot.set_shoot_direction(-1, 0)
	elif direction == "up":
		shoot.set_shoot_direction(0, -1)
	elif direction == "down":
		shoot.set_shoot_direction(0, 1)
		
	get_parent().add_child(shoot)
	shoot.position = shoot_position.global_position
