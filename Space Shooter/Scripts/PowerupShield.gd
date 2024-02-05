extends Powerup
class_name PowerupShield

@export var shieldTime :float = 6


func applyPowerup(player: Player):
	player.applyShield(shieldTime)
