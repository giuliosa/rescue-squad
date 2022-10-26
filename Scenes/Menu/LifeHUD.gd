extends CanvasLayer


func _ready():
	PlayerStats.set_max_health_player($LifePlayer.rect_size.x)
	PlayerStats.set_health_player($LifePlayer.rect_size.x)

	PartnerStats.set_max_health_partner($LifeParter.rect_size.x)
	PartnerStats.set_health_partner($LifeParter.rect_size.x)
	
func _process(_delta):
	$LifePlayer.rect_size.x = PlayerStats.health_player
	$LifeParter.rect_size.x = PartnerStats.health_partner
	
