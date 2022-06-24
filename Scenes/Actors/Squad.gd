extends KinematicBody2D

const Player = preload("res://Scenes/Actors/Player.tscn")
const Shoot = preload("res://Scenes/Shoot.tscn")

const position1 = Vector2(16, 0)
const position2 = Vector2(16, 16)
const position3 = Vector2(-16, 16)
const position4 = Vector2(0, 32)

const ACCELERATION = 600
const MAX_SPEED = 150
const FRICTION = 400

var velocity = Vector2.ZERO

var player_position = []

var all_dead

func _ready():
	put_players_into_squad()
	fix_player_position()
	fix_look_direction()
	
func _process(delta):
	if SquadPosition.are_they_all_dead():
		get_tree().change_scene("res://Scenes/Menu/gameover.tscn")

func _physics_process(delta):
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input_vector = input_vector.normalized()
		
	if input_vector != Vector2.ZERO:
		if input_vector.y == 1 and input_vector.x == 0: 
			for character in player_position:
				character.get_node("AnimationPlayer").play("WalkDown")
		elif input_vector.y == -1 and input_vector.x == 0: 
			for character in player_position:
				character.get_node("AnimationPlayer").play("WalkUp")
		elif input_vector.x > 0:
			for character in player_position:
				character.get_node("AnimationPlayer").play("WalkRight")
		elif input_vector.x < 0: 
			for character in player_position:
				character.get_node("AnimationPlayer").play("WalkLeft")
		velocity = velocity.move_toward(input_vector * MAX_SPEED, ACCELERATION * delta)
	else:
		fix_look_direction()
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
	velocity = move_and_slide(velocity)
	
	if Input.is_action_just_pressed("change_right"):
		change_array_position("right")
	if Input.is_action_just_pressed("change_left"):
		change_array_position("left")
		
	#if Input.is_action_pressed("special_attack"):
	#	if Input.is_action_just_pressed("shoot_right"):
	#		player_special_attack($ShootPositionRight, "right")
	#		player_position[0].get_node("AnimationPlayer").play("SpecialAttack")
			
	#	if Input.is_action_just_pressed("shoot_up"):
	#		player_special_attack($ShootPositionUp, "up")
	#		player_position[3].get_node("AnimationPlayer").play("SpecialAttack")
			
	#	if Input.is_action_just_pressed("shoot_left"):
	#		player_special_attack($ShootPositionLeft, "left")
	#		player_position[2].get_node("AnimationPlayer").play("SpecialAttack")
			
	#	if Input.is_action_just_pressed("shoot_down"):
	#		player_special_attack($ShootPositionDown, "down")
	#		player_position[1].get_node("AnimationPlayer").play("SpecialAttack")
	#else:
	if Input.is_action_just_pressed("shoot_right"):
		player_shoot($ShootPositionRight, "right")
		player_position[0].get_node("AnimationPlayer").play("ShootRight")
		
	if Input.is_action_just_pressed("shoot_up"):
		player_shoot($ShootPositionUp, "up")
		player_position[3].get_node("AnimationPlayer").play("ShootUp")
		
	if Input.is_action_just_pressed("shoot_left"):
		player_shoot($ShootPositionLeft, "left")
		player_position[2].get_node("AnimationPlayer").play("ShootLeft")
		
	if Input.is_action_just_pressed("shoot_down"):
		player_shoot($ShootPositionDown, "down")
		player_position[1].get_node("AnimationPlayer").play("ShootDown")
	
	
		
func put_players_into_squad():
	for i in SquadPosition.position:
		var createad_player = Player.instance()
		createad_player.create_character(i)
		add_child(createad_player)
		player_position.append(createad_player)
	
func change_array_position(direction):
	if direction == "right":
		var last = player_position.pop_back()
		player_position.push_front(last)
		fix_player_position()
		
	elif direction == "left":
		var last = player_position.pop_front()
		player_position.push_back(last)
		fix_player_position()

func fix_player_position():
	player_position[0].position = $RightCharacter.position
	player_position[0].z_index = 2
	
	player_position[1].position = $BottomCharacter.position
	player_position[1].z_index = 3
	
	player_position[2].position = $LeftCharacter.position
	player_position[2].z_index = 2
	
	player_position[3].position = $TopCharacter.position
	player_position[3].z_index = 1
	fix_look_direction()


func fix_look_direction():
	player_position[0].get_node("AnimationPlayer").play("IdleRight")
	player_position[1].get_node("AnimationPlayer").play("IdleDown")
	player_position[2].get_node("AnimationPlayer").play("IdleLeft")
	player_position[3].get_node("AnimationPlayer").play("IdleUp")

func player_shoot(shoot_position, direction):
	var attack
	var is_dead
	match direction:
		"right":
			is_dead = player_position[0].dead
			attack = player_position[0].attack("right")
		"left":
			is_dead = player_position[2].dead
			attack = player_position[2].attack("left")
		"up":
			is_dead = player_position[3].dead
			attack = player_position[3].attack("up")
		"down":
			is_dead = player_position[1].dead
			attack = player_position[1].attack("down")
		_:
			is_dead = false
		
	if !is_dead:	
		get_parent().add_child(attack)
		attack.position = shoot_position.global_position

func player_special_attack(shoot_position, direction):
	var special_attack
	
	match direction:
		"right":
			special_attack = player_position[0].special_attack("right")
		"left":
			special_attack = player_position[2].special_attack("left")
		"up":
			special_attack = player_position[3].special_attack("up")
		"down":
			special_attack = player_position[1].special_attack("down")
		
	get_parent().add_child(special_attack)
	special_attack.position = shoot_position.global_position
