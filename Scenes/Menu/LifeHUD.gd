extends CanvasLayer


func _ready():
	print($LifePlayer.rect_size.x)
	PlayerStats.set_max_health_player($LifePlayer.rect_size.x)
	PlayerStats.set_health_player($LifePlayer.rect_size.x)
	
func _process(delta):
	$LifePlayer.rect_size.x = PlayerStats.health_player
	
