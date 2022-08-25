extends KinematicBody2D

export var ACCELERATION := 300
export var MAX_SPEED := 100
export var FRICTION := 200
export var WANDER_TARGER_RANGE := 4

enum {
	IDLE,
	ALIGN,
	CHASE,
	ATTACK
}

var velocity = Vector2.ZERO
var state := ALIGN
var player : KinematicBody2D = null
var enemy: KinematicBody2D = null
var path : Array = []
var navigation_path: Navigation2D = null
var target = null

var fire_rate = 0.1
var can_fire = true

var bullet_scene = preload("res://Scenes/Overlap/Bullet.tscn")

onready var raycast = $RayCast2D

func _ready():
	yield(get_tree(), "idle_frame")
	state = ALIGN
	player = get_parent().get_node("Character")
	enemy = get_parent().get_node("Ciclope")
	navigation_path = get_parent().get_node("Path")

func _physics_process(delta: float) -> void:
	
	raycast.look_at(get_global_mouse_position())
	if raycast.is_colliding():
		target = raycast.get_collider()
		if "Ciclope" in target.name:
			state = ATTACK
		else:
			state = ALIGN
	match state:
		CHASE:
			chase_state(delta)
		ATTACK:
			attack_state(delta)
		ALIGN:
			if player and navigation_path:
				#Fix this 
				generate_path()
				navigate()
			align_state(delta)
		IDLE:
			idle_state(delta)

func chase_state(_delta):
	pass
	
func attack_state(_delta):
	
	if is_instance_valid(target): 
		print("target",target)
		print(target.global_position)
		var bullet = bullet_scene.instance()
		get_parent().add_child(bullet)
		bullet.global_position = $Position2D.get_global_position()
		var shoot_target = target.global_position
		var direction_to_mouse = bullet.global_position.direction_to(shoot_target).normalized()
		bullet.direction = direction_to_mouse
		
		can_fire = false
		yield(get_tree().create_timer(fire_rate), "timeout")
		can_fire = true
	else:
		state = IDLE	
	
	
	
func align_state(delta):
	velocity = move_and_slide(velocity)
		
func idle_state(delta):
	velocity = Vector2.ZERO
	
func generate_path():
	if player != null and navigation_path != null:
		path = navigation_path.get_simple_path(global_position, player.global_position, false)
	
func navigate():
	if path.size() > 0:
		velocity = global_position.direction_to(path[1]) * MAX_SPEED 
		if global_position == path[0]:
			path.pop_front()

func _on_DetectPartner_body_entered(body):
	print(body.name)
	if(body.name == "Character"):
		state = IDLE


func _on_DetectPartner_body_exited(body):
	if(body.name == "Character"):
		state = ALIGN
		
	
