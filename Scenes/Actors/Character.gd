extends KinematicBody2D


func _process(delta):
	$Position2D/Gun.look_at(get_global_mouse_position())
	print(get_global_mouse_position().x)
	print($Position2D.global_position.x)
	if (get_global_mouse_position().x < $Position2D.global_position.x):
		$Position2D/Body.flip_h = true
		$Position2D/Gun.flip_v = true
	else:
		$Position2D/Body.flip_h = false
		$Position2D/Gun.flip_v = false
