extends "res://Scenes/overlap/Hitbox.gd"

const SPEED = 200
var velocity = Vector2()
var direction = Vector2()
var knockback_vector = Vector2.ZERO

func _physics_process(delta):
	damage = 4
	velocity.x = SPEED * delta * direction.x
	velocity.y = SPEED * delta * direction.y
	translate(velocity)

func set_shoot_direction(dirX, dirY):
	direction.x = dirX
	direction.y = dirY

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()


func _on_Shoot_body_entered(body):
	print(body)
	queue_free()
