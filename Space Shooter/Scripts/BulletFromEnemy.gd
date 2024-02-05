extends Area2D


@export var speed: float = 200

var bulletEffectTemplate := preload("res://Scenes/BulletFromEnemyEffect.tscn")

func _physics_process(delta):
	position.y += speed * delta
	

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()


func _on_area_entered(area):
	if area is Player:
		var bulletEffect := bulletEffectTemplate.instantiate()
		bulletEffect.position = position
		get_parent().add_child(bulletEffect)
		
		area.damage(1)
		queue_free()
