extends KinematicBody2D

export var ACCELERATION := 300
export var MAX_SPEED := 100

export var path_to_player := NodePath()

enum {
	IDLE,
	ALIGN,
	CHASE,
	ATTACK
}

var velocity = Vector2.ZERO
var state := ALIGN

var target = null

var fire_rate = 0.1
var can_fire = true

var bullet_scene = preload("res://Scenes/Overlap/Bullet.tscn")

onready var raycast = $RayCast2D

onready var timer := $Timer
onready var sprite := $Sprite
onready var agent: NavigationAgent2D = $NavigationAgent2D
onready var player := get_node(path_to_player)

func _ready():
	yield(get_tree(), "idle_frame")
	timer.connect("timeout", self, "_update_pathfinding")
	agent.connect("velocity_computed", self, "move")
	
	
func _physics_process(delta: float) -> void:
	if agent.is_navigation_finished():
		return
		
	raycast.look_at(get_global_mouse_position())
	if raycast.is_colliding():
		target = raycast.get_collider()
		
	var target_global_position := agent.get_next_location()
	var direction := global_position.direction_to(target_global_position)
	var desired_velocity := direction * agent.max_speed
	var steering = (desired_velocity - velocity) * delta * 4.0
	velocity += steering
	agent.set_velocity(velocity)

func move(velocity: Vector2):
	move_and_slide(velocity)
	#sprite.rotation = lerp_angle(sprite.rotation, velocity.angle(), 10.0 * get_physics_process_delta_time())
		
		
func attack_state(_delta):	
	if is_instance_valid(target): 
		var bullet = bullet_scene.instance()
		get_parent().add_child(bullet)
		bullet.global_position = $Position2D.get_global_position()
		var shoot_target = target.global_position
		var direction_to_mouse = bullet.global_position.direction_to(shoot_target).normalized()
		bullet.direction = direction_to_mouse
		
		can_fire = false
		yield(get_tree().create_timer(fire_rate), "timeout")
		can_fire = true
	
		
func idle_state(_delta):
	velocity = Vector2.ZERO
	
func _update_pathfinding() -> void:
	agent.set_target_location(player.global_position)

	
func _on_DetectPartner_body_entered(body):
	if(body.name == "Character"):
		#state = IDLE
		pass


func _on_DetectPartner_body_exited(body):
	if(body.name == "Character"):
		pass
		#state = ALIGN
		
	
