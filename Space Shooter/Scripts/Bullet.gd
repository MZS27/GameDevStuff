extends Area2D

@export var speed: float = 500

var bulletEffectTemplate := preload("res://Scenes/BulletEffect.tscn")
var cam: Camera2D = null

func _ready():
	cam = get_tree().current_scene.get_node("Cam")

func _physics_process(delta):
	position.y -= speed * delta
	

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()


func _on_area_entered(area):
	if area.is_in_group("enemy"):
		var bulletEffect := bulletEffectTemplate.instantiate()
		bulletEffect.position = position
		get_parent().add_child(bulletEffect)
		
		cam.shake(1)
		
		area.damage(1)
		queue_free()
