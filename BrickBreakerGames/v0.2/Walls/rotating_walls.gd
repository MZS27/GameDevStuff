extends StaticBody2D


func _ready():
	Messenger.paddle_rotation.connect(rotate_walls)

func rotate_walls(degrees):
	set_rotation_degrees(degrees)

func _process(delta):
	pass
