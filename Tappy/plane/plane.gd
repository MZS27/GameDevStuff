extends CharacterBody2D

#signal on_plane_died

@onready var animation_player := $AnimationPlayer
@onready var animation_sprite_2d := $AnimatedSprite2D
const GRAVITY := 1800.0
const POWER := -400.0

var _die: bool = false

func _ready():
	pass 


func _physics_process(delta):
	velocity.y += GRAVITY * delta;
	
	if is_on_floor():
		die()
	
	if Input.is_action_just_pressed("fly"):
		velocity.y = POWER
		animation_player.play("fly")
	
	move_and_slide()
	pass

func die() -> void:
	if _die == true:
		return
	_die = true
	animation_sprite_2d.stop()
	GameManager.on_game_over.emit()
	set_physics_process(false)
