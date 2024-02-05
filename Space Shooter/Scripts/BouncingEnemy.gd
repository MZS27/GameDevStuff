extends SlowShooterEnemy

@export var horizontalSpeed := 50

var horizontalDirection: int = 1
# -1:left, 1:right

var viewRect: Rect2 = Rect2()

func _ready():
	viewRect = get_viewport_rect()

func _physics_process(delta):
	super._physics_process(delta)
	position.x += horizontalSpeed * horizontalDirection * delta
	if position.x < viewRect.position.x or position.x > viewRect.end.x:
		horizontalDirection *= -1
