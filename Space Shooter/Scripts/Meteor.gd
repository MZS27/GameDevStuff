extends Area2D
class_name Meteor

@export var minSpeed: float = 10
@export var maxSpeed: float = 20
@export var minRotationRate: float = -10
@export var maxRotationRate: float = 10

@export var lifePoints = 10

var playerInArea: Player = null
var speed: float = 0
var rotationRate: float = 0

var meteorEffectTemplate := preload("res://Scenes/MeteorEffect.tscn")

func _ready():
	speed = randf_range(minSpeed, maxSpeed)
	rotationRate = randf_range(minRotationRate, maxRotationRate)

func _process(delta):
	if playerInArea != null and playerInArea is Player:
		playerInArea.damage(1)

func _physics_process(delta):
	position.y += speed * delta
	rotation_degrees += rotationRate * delta

func damage(amount: int):
	if lifePoints <= 0:
		return
	
	lifePoints -= amount
	if lifePoints <= 0:
		var effect = meteorEffectTemplate.instantiate()
		effect.position = position
		get_parent().add_child(effect)
		Signals.emit_signal("on_score_increase",2)
		queue_free()

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()

func _on_area_entered(area):
	if area is Player:
		playerInArea = area

func _on_area_exited(area):
	if area is Player:
		playerInArea = null
