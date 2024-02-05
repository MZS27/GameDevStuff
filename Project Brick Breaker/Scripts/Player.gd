extends CharacterBody2D

var movement_speed = 1000;
var rotation_speed = 600;

var rotation_dir = 0;
var velocityVector = Vector2.ZERO;
var rotationDegrees = 0;

func get_input():
	rotation_dir = 0;
	velocityVector = Vector2.ZERO;
	
	if Input.is_action_pressed("ui_up"):
		velocityVector.y -= 1;
	if Input.is_action_pressed("ui_down"):
		velocityVector.y += 1;
	if Input.is_action_pressed("ui_left"):
		rotationDegrees -= 1;
	if Input.is_action_pressed("ui_right"):
		rotationDegrees += 1;

func _physics_process(delta):
	get_input();
	#set_velocity(velocityVector * movement_speed * delta)
	#move_and_slide();
	print(get_global_transform().get_origin())
	if velocityVector != Vector2.ZERO:
		velocityVector = velocityVector * movement_speed * delta
		set_position(get_global_transform().get_origin() + velocityVector)
	set_rotation_degrees(rotationDegrees * rotation_speed * delta);
