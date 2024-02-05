class_name Brick
extends Node


func break_object():
	Messenger.brick_broken.emit()
	queue_free()
