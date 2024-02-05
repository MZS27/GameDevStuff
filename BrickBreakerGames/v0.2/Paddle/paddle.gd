extends StaticBody2D

@export var SPEED : float = 500


@export var motionVector := Vector2.ZERO
@export var rotationSpeed: float = 400
var rotationDegrees: float = 0
const X_POS : int = 232

func _ready():
	pass

func _physics_process(delta):
	#position.x = X_POS
	horizontal_movement(delta)
	paddle_rotation(delta)
	

func horizontal_movement(delta):
	motionVector.y = 0
	if Input.is_action_pressed("move_down"):
		motionVector.y = SPEED * delta
	if Input.is_action_pressed("move_up"):
		motionVector.y = -SPEED * delta
	move_and_collide(motionVector)

func paddle_rotation(delta):
	rotationDegrees = fmod(rotationDegrees,54)
	if Input.is_action_pressed("rotate_right"):
		rotationDegrees += 1
		set_rotation_degrees(rotationDegrees * rotationSpeed * delta)
		Messenger.paddle_rotation.emit(rotation_degrees)
	if Input.is_action_pressed("rotate_left"):
		rotationDegrees -= 1
		set_rotation_degrees(rotationDegrees * rotationSpeed * delta)
		Messenger.paddle_rotation.emit(rotation_degrees)
