extends StaticBody2D



func _ready():
	Messenger.rotate_walls.connect(rotate_wall)


func rotate_wall(degrees) -> void:
	set_rotation_degrees(degrees)

func _process(delta):
	pass
