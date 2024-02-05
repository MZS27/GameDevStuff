extends Area2D

class_name Player

@onready var animatedSprite := $AnimatedSprite2D
@onready var shieldSprite := $ShieldSprite
@onready var firingPositions := $FiringPositions
@onready var bulletDelayTimer := $BulletDelayTimer
@onready var rapidFireTimer := $RapidFireTimer
@onready var invincibilityTimer := $InvincibilityTimer


var playerBullet := preload("res://Scenes/Bullet.tscn")

@export var speed: float = 200

@export var invincibilityDuration: float = 1
@export var lifePoints: int = 3
var dirVector := Vector2(0,0)
var cam: Camera2D = null

var bulletDelay: float = 0.2
@export var normalBulletDelay: float = 0.2
@export var rapidFireDelay: float = 0.1

func _ready():
	cam = get_tree().current_scene.get_node("Cam")
	shieldSprite.visible = false
	Signals.emit_signal("on_player_life_change", lifePoints)

func _process(delta):
	if dirVector.x < 0:
		animatedSprite.play("move_left")
	elif dirVector.x > 0:
		animatedSprite.play("move_right")
	else:
		animatedSprite.play("steady")
		
	if Input.is_action_pressed("shoot") and bulletDelayTimer.is_stopped():
		bulletDelayTimer.start(bulletDelay)
		for child in firingPositions.get_children():
			var bullet = playerBullet.instantiate()
			bullet.global_position = child.global_position
			get_tree().current_scene.add_child(bullet)
		

func _physics_process(delta):
	dirVector.x = 0
	dirVector.y = 0
	if Input.is_action_pressed("ui_left"):
		dirVector.x = -1
	elif Input.is_action_pressed("ui_right"):
		dirVector.x = 1
	if Input.is_action_pressed("ui_up"):
		dirVector.y = -1
	elif Input.is_action_pressed("ui_down"):
		dirVector.y = 1
	
	var viewRect := get_viewport_rect()
	position += dirVector.normalized() * speed * delta
	position.x = clamp(position.x, 0, viewRect.size.x)
	position.y = clamp(position.y, 0, viewRect.size.y)

func damage(amount: int):
	if !invincibilityTimer.is_stopped():
		return
	
	applyShield(invincibilityDuration)
	
	lifePoints -= amount
	Signals.emit_signal("on_player_life_change", lifePoints)
	
	cam.shake(10)
	
	if lifePoints <= 0:
		print("PLAYER DIED")
		queue_free()

func applyShield(duration: float):
	invincibilityTimer.start(duration + invincibilityTimer.time_left)
	shieldSprite.visible = true

func applyRapidFire(duration: float):
	rapidFireTimer.start(duration + rapidFireTimer.time_left)
	bulletDelay = rapidFireDelay

func _on_invincibility_timer_timeout():
	shieldSprite.visible = false

func _on_rapid_fire_timer_timeout():
	bulletDelay = normalBulletDelay
