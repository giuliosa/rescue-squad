extends KinematicBody2D

const ACCELERATION = 700
const MAX_SPEED = 90
const FRICTION = 400

enum {
	MOVE,
	ROLL,
	ATTACK
}

var state = MOVE
var velocity = Vector2.ZERO

func _process(delta):
	$Position2D/Gun.look_at(get_global_mouse_position())
	if (get_global_mouse_position().x < $Position2D.global_position.x):
		$Position2D/Body.flip_h = true
		$Position2D/Gun.flip_v = true
	else:
		$Position2D/Body.flip_h = false
		$Position2D/Gun.flip_v = false
		

func _physics_process(delta):
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input_vector = input_vector.normalized()
	
	if input_vector != Vector2.ZERO:
		velocity = velocity.move_toward(input_vector * MAX_SPEED, ACCELERATION * delta)
	else:
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
	
	move()


func move():
	velocity = move_and_slide(velocity)
