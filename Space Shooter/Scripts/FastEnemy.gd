extends Enemy

@export var rotationRate: float = 20					

func _process(delta):
	super._process(delta)
	rotate(deg_to_rad(rotationRate) * delta)
