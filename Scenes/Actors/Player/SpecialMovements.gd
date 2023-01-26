extends Sprite

var fire_rate = 0.5
var can_fire = true


var bullet_scene = preload("res://Scenes/Overlap/Bullet.tscn")

onready var gun := $Gun
onready var powerTimer := $PowerTimer

func _ready():
	AmmoStats.max_ammo = 6
	gun.frame = 0
	fire_rate = 0.3
	powerTimer.start()


func _process(delta):
	gun.look_at(get_global_mouse_position())
	
	if Input.is_action_just_pressed("weapon_three"):
		gun.frame = 10
		fire_rate = 1.5
	if Input.is_action_just_pressed("weapon_two"):
		gun.frame = 8
		fire_rate = 0.5
	if Input.is_action_just_pressed("weapon_one"):
		gun.frame = 0
		fire_rate = 0.3


func fire():
	if(can_fire):
		var bullet = bullet_scene.instance()
		
		match gun.frame:
			10:
				bullet.damage = 5
			8: 
				bullet.damage = 3
			0:
				bullet.damage = 2
		
		get_parent().add_child(bullet)
		bullet.global_position = $Gun/Position.get_global_position()
		var target = get_global_mouse_position()
		var direction_to_mouse = bullet.global_position.direction_to(target).normalized()
		bullet.direction = direction_to_mouse
		bullet.rotation_degrees = gun.rotation_degrees
		can_fire = false
		$Timer.start(fire_rate)


func _on_Timer_timeout():
	can_fire = true


func _on_PowerTimer_timeout():
	if PlayerStats.stamina_player < PlayerStats.max_stamina_player:
		PlayerStats.stamina_player += 1
