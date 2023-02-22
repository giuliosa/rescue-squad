extends KinematicBody2D

export var ACCELERATION := 300
export var MAX_SPEED := 100

export var path_to_player := NodePath()

enum {
	IDLE,
	ALIGN,
	ATTACK
}

var velocity = Vector2.ZERO
var state := ALIGN

var target = null

var fire_rate = 9
var can_fire = true

var bullet_scene = preload("res://Scenes/Overlap/Bullet.tscn")

onready var raycast = $RayCast2D
onready var shoot_position := $Body/Position2D

onready var timer := $Timer
onready var sprite := $Body
#onready var gun := $Body/Gun
onready var agent: NavigationAgent2D = $NavigationAgent2D
onready var player := get_node(path_to_player)
onready var hurtbox := $Hurtbox

func _ready():
	yield(get_tree(), "idle_frame")
	timer.connect("timeout", self, "_update_pathfinding")
	agent.connect("velocity_computed", self, "move")
	
	
func _physics_process(delta: float) -> void:
	if agent.is_navigation_finished():
		return
		
		
	match state:
		IDLE:
			pass
		ATTACK:
			attack_state(delta)
		ALIGN:
			pass
			
	raycast.look_at(get_global_mouse_position())
	if raycast.is_colliding():
		target = raycast.get_collider()
		state = ATTACK
	else: 
		state = ALIGN
		
	var target_global_position := agent.get_next_location()
	var direction := global_position.direction_to(target_global_position)
	var desired_velocity := direction * agent.max_speed
	var steering = (desired_velocity - velocity) * delta * 4.0
	velocity += steering
	agent.set_velocity(velocity)

func move(velocity: Vector2):
	sprite.flip_h = velocity.x < 0
	#gun.flip_h = velocity.x < 0
	move_and_slide(velocity)
		
		
func attack_state(_delta):	
	if is_instance_valid(target): 
		var bullet = bullet_scene.instance()
		get_parent().add_child(bullet)
		bullet.global_position = shoot_position.get_global_position()
		var shoot_target = target.global_position
		var direction_to_mouse = bullet.global_position.direction_to(shoot_target).normalized()
		bullet.direction = direction_to_mouse
		
		can_fire = false
		#TODO: Verificar o fireRate também
		$FireRateTimer.start(2)
		
	
		
func idle_state(_delta):
	velocity = Vector2.ZERO
	
func _update_pathfinding() -> void:
	agent.set_target_location(player.global_position)


func _on_Hurtbox_area_entered(area):
	PartnerStats.health_partner -= area.damage
	hurtbox.start_invicibility(0.6)
	hurtbox.create_hit_effect()


func _on_DetectPlayer_area_entered(area):
	#TODO: Testar depois 
	velocity = Vector2.ZERO


func _on_FireRateTimer_timeout():
	can_fire = true
