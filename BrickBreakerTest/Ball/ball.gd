extends RigidBody2D

@export var ballSpeed = 500
var ballVector := Vector2.ZERO
var collisionObject: KinematicCollision2D 

var collider

func _ready():
	ballVector.x = -1

func _physics_process(delta):
	collisionObject = move_and_collide(ballVector * ballSpeed * delta)
	
	if collisionObject:		
		collider = collisionObject.get_collider()
		if collider.is_in_group("reflectObjects"):
			ballVector = collisionObject.get_normal() # This gives a unit vector aligned perpendicularly
			# to the collision object surface. Helps the player send the ball in the direction he desires. Took me an embarassingly long time to figure out how to do this.
			#print('Collison Object Velocity: ',collider)
		else:
			ballVector = ballVector.bounce(collisionObject.get_normal())
			
		if collider.is_in_group("brick"):
			collider.destroy_brick()
			Messenger.check_all_bricks_destroyed.emit()
		elif collider.is_in_group("barrier"):
			collider.queue_free()
