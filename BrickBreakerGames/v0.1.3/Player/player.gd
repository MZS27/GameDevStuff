extends StaticBody2D

var motionVector := Vector2.ZERO
var rotationDegrees: float = 0
@export var MOVEMENT_SPEED : float = 25
@export var ROTATION_SPEED : float = 108
var MAX_ROTATION_ACC : float = 2.9
var MIN_ROTATION_ACC : float = MAX_ROTATION_ACC * -1

var rotationAcc: float = 0
var globalPosX: float = 400

var isMoving : bool = false
var isRotating: bool = false

func _ready():
	globalPosX = global_position.x
	rotationAcc = ROTATION_SPEED

func _process(delta):
	global_position.x = globalPosX

func _physics_process(delta):
	if Input.is_action_pressed("move_down"):
		motionVector.y += MOVEMENT_SPEED * delta
		move_and_collide(motionVector)
		isMoving = true
	elif Input.is_action_pressed("move_up"):
		motionVector.y -= MOVEMENT_SPEED * delta
		move_and_collide(motionVector)
		isMoving = true
	else:
		motionVector.y = lerp(motionVector.y, 0.0, 0.4)
		isMoving = false
	if Input.is_action_pressed("rotate_right"):
		rotationDegrees += 0.1
		if rotationAcc >= MAX_ROTATION_ACC:
			rotationAcc = MAX_ROTATION_ACC
		elif rotationAcc < 0:
			rotationAcc = 0
		else:
			rotationAcc += 0.15
		rotationDegrees += rotationAcc
		isRotating = true
		set_rotation_degrees((rotationDegrees + rotationAcc) * ROTATION_SPEED * delta)
	elif Input.is_action_pressed("rotate_left"):
		rotationDegrees -= 0.1
		if rotationAcc <= MIN_ROTATION_ACC:
			rotationAcc = MIN_ROTATION_ACC
		elif rotationAcc > 0:
			rotationAcc = 0
		else:
			rotationAcc -= 0.15
		rotationDegrees += rotationAcc
		isRotating = true
		set_rotation_degrees(rotationDegrees * ROTATION_SPEED * delta)
	else:
		rotationAcc = 0
		isRotating = false

#func check_paddle_limit():
	#if global_position.y > GameManager.paddleLowerLimit:
		#global_position.y = GameManager.paddleLowerLimit
	#if global_position.y < GameManager.paddleUpperLimit:
		#global_position.y = GameManager.paddleUpperLimit
#
