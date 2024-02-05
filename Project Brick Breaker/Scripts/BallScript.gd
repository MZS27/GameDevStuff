extends CharacterBody2D

var speed = 500;
var ballVelocity = Vector2.ZERO;
	#velocity.y = speed;

func _ready():
	randomize();
	ballVelocity.x = -1;
	

func _physics_process(delta):
	var collision_object = move_and_collide(ballVelocity * speed * delta);
	if collision_object:
		ballVelocity = ballVelocity.bounce(collision_object.get_normal())
