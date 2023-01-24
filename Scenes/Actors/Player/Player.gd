extends KinematicBody2D

const ACCELERATION = 1000
const FRICTION = 10000 

enum {
	MOVE,
	DASH,
	ATTACK
}

var max_speed = 150
var roll_speed = max_speed * 3

var state = MOVE
var velocity = Vector2.ZERO
var roll_vector := Vector2.ZERO

onready var hurtbox := $Hurtbox
onready var knifeHitbox:= $Knife/Hitbox
onready var animationPlayer = $AnimationPlayer
onready var animationTree = $AnimationTree
onready var animationState = animationTree.get("parameters/playback")

func _ready():
	randomize()
	PlayerStats.connect("no_health_player", self, "game_over")
	PlayerStats.connect("stamina_changed", self, "stamina_recover")
	animationTree.active = true

func _process(_delta):	
	#TODO: Remove this, and put to open the menu
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().change_scene("res://Scenes/Menu/TitleScreen.tscn")
	
	$Knife.look_at(get_global_mouse_position())
	if (get_global_mouse_position().x < $Position2D.global_position.x):
		$Position2D/Body.flip_h = true
		$Position2D/Weapon/Gun.flip_v = true
	else:
		$Position2D/Body.flip_h = false
		$Position2D/Weapon/Gun.flip_v = false
		
	if Input.is_action_pressed("mouse_shoot"):
		$Position2D/Weapon.fire()
	
	if Input.is_action_just_pressed("mouse_secondary"):
		$AnimationPlayer.play("Knife_Attack")
		
	if Input.is_action_just_pressed("slow_time"):
		#Make this more dinamic
		max_speed = 900
		$SlowTime.start(2, 0.7)
	else:
		max_speed = 150
		
	if !animationState.get_current_node() == "Idle" && Input.is_action_just_pressed("special_move"):
		state = DASH

func _physics_process(delta):
	knifeHitbox.knockback_vector = get_local_mouse_position().normalized()
	
	match state:
		MOVE:
			move_state(delta)
		DASH: 
			dash_state(delta)

func move_state(delta):
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("walk_right") - Input.get_action_strength("walk_left")
	input_vector.y = Input.get_action_strength("walk_down") - Input.get_action_strength("walk_up")
	input_vector = input_vector.normalized()
	
	if input_vector != Vector2.ZERO:
		roll_vector = input_vector
		animationTree.set("parameters/Idle/blend_position", input_vector)
		animationTree.set("parameters/Run/blend_position", input_vector)
		animationTree.set("parameters/Dash/blend_position", input_vector)
		animationState.travel("Run")
		velocity = velocity.move_toward(input_vector * max_speed, ACCELERATION * delta)
	else:
		animationState.travel("Idle")
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
	
	move()
	
func dash_state(_delta):
	PlayerStats.stamina_player -= 1
	velocity = roll_vector * roll_speed
	animationState.travel("Dash")
	move()

func move():
	velocity = move_and_slide(velocity)
	
func game_over():
	get_tree().change_scene("res://Scenes/Menu/gameover.tscn")

func _on_GunShoot_animation_finished():
	$Position2D/Gun/Position/GunShoot.stop()

func dash_animation_finished():
	state = MOVE
	
func stamina_recover():
	$StaminaRecover.start()
	

func _on_Hurtbox_area_entered(area):
	PlayerStats.health_player -= area.damage
	hurtbox.start_invicibility(0.6)
	hurtbox.create_hit_effect()



func _on_StaminaRecover_timeout():
	#TODO: Fix stamina recover
	PlayerStats.health_player += 1
