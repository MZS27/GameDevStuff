extends RigidBody2D

var ballDirection := Vector2.ZERO
@export var ballSpeed : float = 400
var collisionObject: KinematicCollision2D = null
var speedAcc: float = 1

const BALL_DIR_X_MIN_RIGHT: float = 0.15
const BALL_DIR_X_MIN_LEFT: float = BALL_DIR_X_MIN_RIGHT * -1
const BALL_DIR_X_ADJUSTMENT: float = 0.025
#var wasCollidingWithMovingPaddle: bool = false

func _ready():
	ballDirection.x = -1


func _process(delta):
	#if wasCollidingWithMovingPaddle: ballDirection = Vector2.ZERO
	#else: ballSpeed = BALL_STABLE_SPEED
	collisionObject = move_and_collide(ballDirection * ballSpeed * speedAcc * delta)
	if collisionObject:
		var collider := collisionObject.get_collider()
		if collider.is_in_group("reflector"):
			ballDirection = collisionObject.get_normal()
		else:
			ballDirection = ballDirection.bounce(collisionObject.get_normal())
		
		if collider.is_in_group("breakable"):
			collider.destroy_object()
		
		if collider.is_in_group("controlled"):
			collider.on_collision_action()
		
		if collider is Player:
			if collider.isMoving or collider.isRotating:
				#wasCollidingWithMovingPaddle = true
				speedAcc = 1.5
			#wasCollidingWithMovingPaddle = false
		else:
			#wasCollidingWithMovingPaddle = false
			if speedAcc > 1:
				speedAcc = lerp(speedAcc, 1.0, 0.1)
		check_ball_stuck_vertically()

#func destroy_brick(collider):
	#collider.destroy_object()
	#Messenger.brick_broken.emit()

func check_ball_stuck_vertically():
	if ballDirection.x > 0 and ballDirection.x < BALL_DIR_X_MIN_RIGHT:
		ballDirection.x += BALL_DIR_X_ADJUSTMENT
		if ballDirection.x > BALL_DIR_X_MIN_RIGHT:
			ballDirection.x = BALL_DIR_X_MIN_RIGHT
	elif ballDirection.x <= 0 and ballDirection.x > BALL_DIR_X_MIN_LEFT:
		ballDirection.x -= BALL_DIR_X_ADJUSTMENT
		if ballDirection.x < BALL_DIR_X_MIN_LEFT:
			ballDirection.x = BALL_DIR_X_MIN_LEFT
