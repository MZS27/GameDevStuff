extends TextureRect

@onready var shooter = $"../../Shooter"
@onready var instructions = $Instructions
var movementDone: bool = false
var rotationDone: bool = false
var bulletFillDone: bool = false
var shootDone: bool = false



func _ready():
	pass 

func _process(delta):
	if not movementDone:
		instructions.set_text("Use Up & Down Arrow Keys to Move Paddle")
		if Input.is_action_pressed("move_up") or Input.is_action_pressed("move_down"):
			movementDone = true
	elif not rotationDone:
		instructions.set_text("Use Left & Right Arrow Keys to Rotate Paddle")
		if Input.is_action_pressed("rotate_left") or Input.is_action_pressed("rotate_right"):
			rotationDone = true
	elif not bulletFillDone:
		instructions.set_text("Bullets are loaded when the ball hits the shooter")
		if shooter.bulletCount > 0:
			bulletFillDone = true
	elif not shootDone:
		instructions.set_text("Press Z to Shoot")
		if Input.is_action_pressed("object_action"):
			shootDone = true 
	else:
		queue_free()
