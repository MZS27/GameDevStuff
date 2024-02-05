extends CharacterBody2D

var playerSpeed: int = 200
var direction := Vector2(0,0)

var gravity = 1500
var gacc = 500

var jumpPower = 10000

@onready var aniSprite = $AnimatedSprite2D

func _physics_process(delta):
	
	
	if Input.is_action_pressed("ui_left"):
		velocity.x -= playerSpeed * delta
		aniSprite.play("Run")
		aniSprite.flip_h = false
	elif Input.is_action_pressed("ui_right"):
		velocity.x += playerSpeed * delta
		aniSprite.play("Run")
		aniSprite.flip_h = true
	else:
		velocity.x = 0
		aniSprite.play("Idle")
		
	if Input.is_action_just_pressed("ui_up") && is_on_floor():
		velocity.y -= (velocity.y + jumpPower) * delta
	else:
		velocity.y += min(velocity.y + gacc, gravity) * delta
		
	move_and_slide()
