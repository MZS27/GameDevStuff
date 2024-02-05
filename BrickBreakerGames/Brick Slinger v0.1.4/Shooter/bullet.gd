extends StaticBody2D
class_name Bullet

var directionVector:= Vector2.ZERO
@export var movementSpeed: float = 200
var collisionObject: KinematicCollision2D = null

func _ready():
	pass 

func _process(delta):
	collisionObject = move_and_collide(movementSpeed * directionVector * delta)
	if collisionObject:
		var collider = collisionObject.get_collider()
		if collider.is_in_group("breakable"): 
			collider.destroy_object()
		queue_free()
