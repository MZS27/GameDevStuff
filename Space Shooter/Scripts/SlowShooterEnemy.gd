extends Enemy
class_name SlowShooterEnemy

@export var bulletDelay: float = 3.0
@onready var fireTimer = $FireTimer

func _process(delta):
	super._process(delta)
	if fireTimer.is_stopped():
		fire()
		fireTimer.start(bulletDelay)
