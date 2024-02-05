extends Node

signal swiped(direction:float)
signal swipe_canceled(start_pos:float)

@export var _fireball_speed : float = 200
const FIREBALL = preload("res://Fireball/fireball.tscn")

var swipeEffect := preload("res://ParticleEffects/swipe_particles.tscn")

@onready var timer := $Timer
var swipe_start_pos := Vector2()
var swipe_end_pos := Vector2()
var direction


func _input(event):
	if event is InputEventScreenTouch:
		if event.is_pressed():
			_start_detection(event.position)
		elif not timer.is_stopped():
			_end_detection(event.position)
	if event is InputEventScreenDrag:	
		create_swipe_effect(event.position)

func create_swipe_effect(position):
	var swipe_effect_obj = swipeEffect.instantiate()
	add_child(swipe_effect_obj)
	swipe_effect_obj.global_position = swipe_effect_obj.get_global_mouse_position()
	
	

func _start_detection(position):
	swipe_start_pos = position
	timer.start()

func _end_detection(position):
	timer.stop()
	swipe_end_pos = position
	direction = (swipe_end_pos - swipe_start_pos).normalized()
	throw_fireball()
	print_signal()

func print_signal():
	print('Start: ',swipe_start_pos)
	print('End: ',swipe_end_pos)
	print('Direction: ', direction)

func throw_fireball():
	if direction.x == 0 and direction.y == 0:
		return
	var fireball_obj = FIREBALL.instantiate()
	get_parent().add_child(fireball_obj)
	fireball_obj.set_params(swipe_end_pos, direction)
	print(fireball_obj)
	
