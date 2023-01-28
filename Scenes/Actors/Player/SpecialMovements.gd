extends Sprite

var fire_rate = 0.5
var can_fire = true


var bullet_scene = preload("res://Scenes/Overlap/Bullet.tscn")

onready var gun := $Gun
onready var powerTimer := $PowerTimer
onready var reload_timer := $ReloadTimer

func _ready():
	PlayerStats.ammo_player = 7
	
	powerTimer.start()
	
	PlayerStats.connect("no_ammo_player", self, "reaload_ammo")


func _process(delta):
	gun.look_at(get_global_mouse_position())


func fire():
	if(can_fire and PlayerStats.ammo_player > 0):
		PlayerStats.ammo_player -= 1
		var bullet = bullet_scene.instance()
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


func reaload_ammo():
	can_fire = false
	reload_timer.start()


func _on_ReloadTimer_timeout():
	PlayerStats.ammo_player = 7
	reload_timer.stop()
	can_fire = true
