extends Camera2D
class_name Cam

@export var shakeBaseAmount: float = 1.0
@export var shakeDampening: float = 0.075
var shakeAmount: float = 0

func _process(delta):
	if shakeAmount > 0:
		position.x = randf_range(-shakeBaseAmount, shakeBaseAmount) * shakeAmount
		position.y = randf_range(-shakeBaseAmount, shakeBaseAmount) * shakeAmount
		shakeAmount = lerp(shakeAmount, 0.0, shakeDampening)
	else:
		position = Vector2(0,0)

func shake(magnitude: float):
	shakeAmount += magnitude
	
