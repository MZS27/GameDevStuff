extends StaticBody2D

@export var SPEED : float = 10
var motionVector := Vector2.ZERO
var rotationDegrees : float = 0
@export var rotationSpeed : float = 400
var acc: float = 40 #acceleration


func _ready():
	pass


func _physics_process(delta):
	#motionVector = Vector2.ZERO
	if Input.is_action_pressed("ui_down"):
		#motionVector.y += min((motionVector.y + acc) * delta, SPEED * delta)
		motionVector.y += SPEED * delta
		move_and_collide(motionVector)
	elif Input.is_action_pressed("ui_up"):
		#motionVector.y -= min((motionVector.y + acc) * delta, SPEED * delta)
		motionVector.y -= SPEED * delta
		move_and_collide(motionVector)
	else:
		motionVector.y = lerp(motionVector.y, float(0), 0.2)
	if Input.is_action_pressed("ui_left"):
		rotationDegrees -= 1
		set_rotation_degrees(rotationDegrees * rotationSpeed * delta)
		Messenger.rotate_walls.emit(rotation_degrees)
	elif Input.is_action_pressed("ui_right"):
		rotationDegrees += 1
		set_rotation_degrees(rotationDegrees * rotationSpeed * delta)
		Messenger.rotate_walls.emit(rotation_degrees)
		

