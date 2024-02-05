extends Node2D

@onready var shooter_sprite = $ShooterSprite
@onready var shooting_point = $ShooterSprite/ShootingPoint
@onready var centre_point = $ShooterSprite/CentrePoint
const BULLET = preload("res://Shooter/bullet.tscn")
var bulletCount: int = 0
const MAX_BULLETS : int = 3

func _ready():
	Messenger.rotate_objects.connect(rotate_shooter)
	bullet_count_animation()

func _process(delta):
	if Input.is_action_just_released("object_action"):
		shoot_bullet()

func rotate_shooter(degrees: float):
	set_rotation_degrees(degrees)

func shoot_bullet():
	if bulletCount == 0:
		return
	bulletCount-=1
	var bulletObj = BULLET.instantiate()
	bulletObj.set_rotation_degrees(rotation_degrees)
	bulletObj.directionVector = (shooting_point.global_position - centre_point.global_position).normalized()
	get_parent().add_child(bulletObj)
	bulletObj.global_position = shooting_point.global_position
	bullet_count_animation()

func on_collision_action():
	if bulletCount < MAX_BULLETS:
		bulletCount+=1
		bullet_count_animation()

func bullet_count_animation():
	shooter_sprite.play("b" + str(bulletCount))
