extends Hitboxa

const SPEED = 200
var velocity = Vector2()
var direction = Vector2()
var knockback_vector = Vector2.ZERO
var shoot_type

func _physics_process(delta):
	knockback_vector = velocity
	velocity.x = SPEED * delta * direction.x
	velocity.y = SPEED * delta * direction.y
	translate(velocity)

func set_shoot_direction(dirX, dirY):
	direction.x = dirX
	direction.y = dirY
	if (dirX == 1 and dirY == 0):
		self.rotation_degrees = 0
	elif (dirX == -1 and dirY == 0):
		self.rotation_degrees = 180
	elif (dirX == 0 and dirY == -1):
		self.rotation_degrees = 270
	elif (dirX == 0 and dirY == 1):
		self.rotation_degrees = 90

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

func _on_Shoot_body_entered(body):
	queue_free()
