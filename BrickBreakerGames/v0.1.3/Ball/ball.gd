extends RigidBody2D

@export var BALL_SPEED : float = 400
var ballDirection := Vector2.ZERO
var collisionObject: KinematicCollision2D = null
var speedAcc: float = 1

func _ready():
	ballDirection.x = -1 

func _physics_process(delta):
	ball_movement(delta)

func ball_movement(delta):
	collisionObject = move_and_collide(ballDirection * BALL_SPEED * speedAcc * delta)
	if collisionObject:
		var collider := collisionObject.get_collider()		
		if collider.is_in_group("reflector"):
			ballDirection = collisionObject.get_normal()
			if collider.isMoving == true or collider.isRotating == true: 
				speedAcc = 1.5
				#apply_impulse(ballDirection * (BALL_SPEED + speedAcc) * delta)
		else:
			ballDirection = ballDirection.bounce(collisionObject.get_normal())
		if collider.is_in_group("breakable"):
			collider.break_object()
		if speedAcc > 1:
			speedAcc = lerp(speedAcc, 1.0, 0.1)
