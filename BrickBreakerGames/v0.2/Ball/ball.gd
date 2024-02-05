extends RigidBody2D

@export var ballSpeed : float = 400
var ballVector := Vector2.ZERO
var collisionObject: KinematicCollision2D
var destroy_brick_effect = preload("res://ParticleEffects/destroy_particle_effect.tscn")

func _ready():
	ballVector.x = -1
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	collisionObject = move_and_collide(ballVector * ballSpeed * delta)
	if collisionObject:
		var collider = collisionObject.get_collider()
		if collider.is_in_group("ball_reflector"):
			ballVector = collisionObject.get_normal()
			apply_impulse(ballVector * ballSpeed * delta)
		else:
			ballVector = ballVector.bounce(collisionObject.get_normal())
		if collider.is_in_group("bricks"):
			destroy_brick(collider)
		if collider.is_in_group("barrier"):
			collider.destroy()
		

func destroy_brick(brick_obj):
	Messenger.brick_destroyed.emit()
	var destroy_effect = destroy_brick_effect.instantiate()
	get_tree().get_root().add_child(destroy_effect)
	destroy_effect.global_position = brick_obj.global_position
	brick_obj.destroy()
	#Messenger.check_game_won.emit()
