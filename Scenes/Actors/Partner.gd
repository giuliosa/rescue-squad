extends KinematicBody2D

export var ACCELERATION := 300
export var MAX_SPEED := 50
export var FRICTION := 200
export var WANDER_TARGER_RANGE := 4



enum {
	IDLE,
	ALIGN,
	CHASE,
	ATTACK
}

var velocity = Vector2.ZERO
var state := IDLE
var player : KinematicBody2D = null
var path : Array = []

onready var raycast = $RayCast2D

func _ready():
	yield(get_tree(), "idle_frame")
	
	player = get_parent().get_node("Character")

func _physics_process(delta: float) -> void:
	if raycast.is_colliding():
		print (raycast.get_collider())
	state = ALIGN
			
	match state:
		CHASE:
			chase_state(delta)
		ATTACK:
			attack_state(delta)
		ALIGN:
			align_state(delta)
		IDLE:
			pass

func chase_state(_delta):
	pass
	
func attack_state(_delta):
	pass
	
	
func align_state(delta):
	if player != null:
		velocity = global_position.direction_to(player.global_position)
		global_position += velocity * MAX_SPEED * delta
		
	velocity = move_and_slide(velocity)
		


