extends KinematicBody2D

const ACCELERATION = 1000
const MAX_SPEED = 150
const ROLL_SPEED = MAX_SPEED * 3
const FRICTION = 500 

enum {
	MOVE,
	DASH,
	ATTACK
}

var state = MOVE
var velocity = Vector2.ZERO
var roll_vector = Vector2.RIGHT

onready var hurtbox := $Hurtbox
onready var knifeHitbox:= $Knife/Hitbox

func _ready():
	PlayerStats.connect("no_health_player", self, "game_over")

func _process(delta):	
	#TODO: Remove this, and put in the real world scene
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().quit()
	
	$Knife.look_at(get_global_mouse_position())
	if (get_global_mouse_position().x < $Position2D.global_position.x):
		$Position2D/Body.flip_h = true
		$Position2D/Gun/Gun.flip_v = true
	else:
		$Position2D/Body.flip_h = false
		$Position2D/Gun/Gun.flip_v = false
		
	if Input.is_action_pressed("mouse_shoot"):
		$Position2D/Gun.fire()
	
	if Input.is_action_just_pressed("mouse_secondary"):
		$AnimationPlayer.play("Knife_Attack")
		
	if Input.is_action_just_pressed("special_move"):
		dash_state(delta)

func _physics_process(delta):	
	roll_vector = get_local_mouse_position().normalized()
	knifeHitbox.knockback_vector = roll_vector
	
	match state:
		MOVE:
			move_state(delta)
		DASH: 
			dash_state(delta)

func move_state(delta):
	#$AnimationPlayer.play("Run")
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("walk_right") - Input.get_action_strength("walk_left")
	input_vector.y = Input.get_action_strength("walk_down") - Input.get_action_strength("walk_up")
	input_vector = input_vector.normalized()
	
	if input_vector != Vector2.ZERO:
		
		velocity = velocity.move_toward(input_vector * MAX_SPEED, ACCELERATION * delta)
	else:
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
	
	move()
	
func dash_state(_delta):
	velocity = roll_vector * ROLL_SPEED
	move()

func move():
	velocity = move_and_slide(velocity)
	
func game_over():
	get_tree().change_scene("res://Scenes/Menu/gameover.tscn")

func _on_GunShoot_animation_finished():
	$Position2D/Gun/Position/GunShoot.stop()


func _on_Hurtbox_area_entered(area):
	PlayerStats.health_player -= area.damage
	hurtbox.start_invicibility(0.6)
	hurtbox.create_hit_effect()
