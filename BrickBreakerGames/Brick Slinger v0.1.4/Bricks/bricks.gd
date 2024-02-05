extends StaticBody2D
class_name Brick

@export_enum("Violet", "Blue", "Red", "Yellow") var color: String
@onready var brick_violet = $Brick_Violet
@onready var brick_blue = $Brick_Blue
@onready var brick_red = $Brick_Red
@onready var brick_yellow = $Brick_Yellow

func _ready():
	brick_yellow.visible = false
	if color == "Violet":
		brick_violet.visible = true
	elif color == "Blue":
		brick_blue.visible = true
	elif color == "Red":
		brick_red.visible = true
	else:
		brick_yellow.visible = true

func destroy_object():
	Messenger.brick_broken.emit()
	queue_free()

