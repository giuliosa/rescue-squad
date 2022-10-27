extends CanvasLayer


func _ready():
	PlayerStats.set_max_health_player($Player/Life.rect_size.x)
	PlayerStats.set_health_player($Player/Life.rect_size.x)

	PartnerStats.set_max_health_partner($Partner/Life.rect_size.x)
	PartnerStats.set_health_partner($Partner/Life.rect_size.x)
	
func _process(_delta):
	$Player/Life.rect_size.x = PlayerStats.health_player
	$Partner/Life.rect_size.x = PartnerStats.health_partner
	
