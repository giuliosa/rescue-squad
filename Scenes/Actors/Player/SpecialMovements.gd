extends Sprite

var fire_rate = 0.4
var can_fire = true

var bullet_scene = preload("res://Scenes/Overlap/Bullet.tscn")

onready var weapon := $Gun

func _ready():
	pass


func _process(delta):
	weapon.look_at(get_global_mouse_position())
	#$Knife.look_at(get_global_mouse_position())
	# if (get_global_mouse_position().x < $Position2D.global_position.x):
	# 	$Gun.flip_v = true
	# else:
	# 	$Gun.flip_v = false


func fire():
	#$AnimationPlayer.play("Shoot")
	var bullet = bullet_scene.instance()
	get_parent().add_child(bullet)
	bullet.global_position = $Gun/Position.get_global_position()
	var target = get_global_mouse_position()
	var direction_to_mouse = bullet.global_position.direction_to(target).normalized()
	bullet.direction = direction_to_mouse
	bullet.rotation_degrees = $Gun.rotation_degrees
	can_fire = false
	yield(get_tree().create_timer(fire_rate), "timeout")
	can_fire = true
