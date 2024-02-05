class_name Player
extends StaticBody2D

@export var movementSpeed : float = 50
@export var rotationSpeed : float = 50

const PADDLE_X_POS : float = 200

const MAX_ROTATION_ACC : float = 5.0
const MIN_ROTATION_ACC : float = MAX_ROTATION_ACC * -1
const ROTATION_ACC_INCR: float = 0.2

var motionVector: Vector2 = Vector2.ZERO
var rotationDegrees: float = 0
var rotationAcc: float = 0

var isMoving: bool = false
var isRotating: bool = false

func _process(delta):
	global_position.x = PADDLE_X_POS

func _physics_process(delta):
	horizontal_movement(delta)
	rotational_movement(delta)

func horizontal_movement(delta):
	if Input.is_action_pressed("move_up"):
		motionVector.y -= movementSpeed * delta
		move_and_collide(motionVector)
		isMoving = true
	elif Input.is_action_pressed("move_down"):
		motionVector.y += movementSpeed * delta
		move_and_collide(motionVector)
		isMoving = true
	else:
		motionVector.y = lerp(motionVector.y, 0.0, 0.5)
		isMoving = false

func rotational_movement(delta):
	if Input.is_action_pressed("rotate_left"):
		rotationDegrees = rotationDegrees - 1 + accelerate_rotation_left()
		set_rotation_degrees(rotationDegrees * rotationSpeed * delta)
		isRotating = true
		Messenger.rotate_objects.emit(rotation_degrees)
	elif Input.is_action_pressed("rotate_right"):
		rotationDegrees = rotationDegrees + 1 + accelerate_rotation_right()
		set_rotation_degrees(rotationDegrees * rotationSpeed * delta)
		isRotating = true
		Messenger.rotate_objects.emit(rotation_degrees)
	else:
		rotationAcc = 0
		isRotating = false

func accelerate_rotation_left() -> float:
	if rotationAcc <= MIN_ROTATION_ACC:
		rotationAcc = MIN_ROTATION_ACC
	elif rotationAcc > 0:
		rotationAcc = 0
	else:
		rotationAcc -= ROTATION_ACC_INCR
	return rotationAcc

func accelerate_rotation_right() -> float:
	if rotationAcc >= MAX_ROTATION_ACC:
		rotationAcc = MAX_ROTATION_ACC
	elif rotationAcc < 0:
		rotationAcc = 0
	else:
		rotationAcc += ROTATION_ACC_INCR
	return rotationAcc
