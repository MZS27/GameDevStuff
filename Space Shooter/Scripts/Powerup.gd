extends Area2D
class_name Powerup

@export var powerupMoveSpeed :float = 50

func _physics_process(delta):
	position.y += powerupMoveSpeed * delta

func applyPowerup(player: Player):
	pass

func _on_area_entered(area):
	if area is Player:
		applyPowerup(area)
		queue_free()

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
