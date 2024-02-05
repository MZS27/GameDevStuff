extends Powerup

@export var rapidFireTime: float = 5

func applyPowerup(player: Player):
	player.applyRapidFire(rapidFireTime)
