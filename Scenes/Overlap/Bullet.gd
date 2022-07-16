extends Area2D


const SPEED = 1000
var direction = Vector2()
var damage = 4

func _process(delta):
	translate(direction.normalized() * SPEED * delta)

func _on_Bullet_body_entered(body):
	queue_free()

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
