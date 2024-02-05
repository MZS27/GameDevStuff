class_name Fireball
extends RigidBody2D

var start_pos := Vector2()
var direction := Vector2()

@export var FIREBALL_SPEED : float = 1200

# Called when the node enters the scene tree for the first time.
func _ready():
	set_physics_process(false)

func set_params(start_pos_param: Vector2, direction_param: Vector2):
	start_pos = start_pos_param
	direction = direction_param
	begin_movement()

func begin_movement():
	position = start_pos
	set_physics_process(true)

func _physics_process(delta):
	move_and_collide(direction * FIREBALL_SPEED * delta)
