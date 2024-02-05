extends Area2D
class_name Enemy

@onready var firingPositions := $FiringPositions
var playerBullet := preload("res://Scenes/BulletFromEnemy.tscn")
var EnemyExplosionTemplate := preload("res://Scenes/EnemyExplosionEffect.tscn")

@export var verticalSpeed: float = 50
@export var healthPoints = 10

var playerInArea: Player = null

func _process(delta):
	if playerInArea != null and playerInArea is Player:
		playerInArea.damage(1)

func _physics_process(delta):
	position.y += verticalSpeed * delta

func damage(amount: int):
	if healthPoints <= 0:
		return
	healthPoints -= amount
	if healthPoints <= 0:
		var explosionEffect := EnemyExplosionTemplate.instantiate()
		explosionEffect.global_position = global_position
		get_tree().current_scene.add_child(explosionEffect)
		Signals.emit_signal("on_score_increase",1)
		queue_free()
		
func fire():
	for child in firingPositions.get_children():
			var bullet = playerBullet.instantiate()
			bullet.global_position = child.global_position
			get_tree().current_scene.add_child(bullet)

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()


func _on_area_entered(area):
	if area is Player:
		playerInArea = area


func _on_area_exited(area):
	if area is Player:
		playerInArea = null
