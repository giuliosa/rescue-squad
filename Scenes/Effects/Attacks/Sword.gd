extends Area2D

var knockback_vector = Vector2.ZERO
var damage = 1
var shoot_type = "sword"

func _physics_process(delta):
	$AnimatedSprite.play()
	$AnimatedSprite.connect("animation_finished", self, "end_sword_attack")
	
func end_sword_attack():
	self.queue_free()
