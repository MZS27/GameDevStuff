extends Node2D

var hit_spot := Rect2(Vector2.ZERO, Game.CELL_SIZE)
var hit_color := Color.TRANSPARENT

@onready var snake := %snake as Snake

func _ready():
	snake.hit.connect(_on_snake_hit) 


func _process(delta):
	queue_redraw()

func _draw() -> void:
	draw_rect(hit_spot, hit_color)

func _on_snake_hit(miniSnake_hit: MiniSnake):
	hit_spot.position = Vector2(miniSnake_hit.current_position)
	
	var tween_pulse = create_tween().set_trans(Tween.TRANS_CIRC).set_loops()
	tween_pulse.tween_property(self, "hit_color", Colors.RED, 0.55).set_ease(Tween.EASE_OUT)
	tween_pulse.tween_property(self, "hit_color", Color.TRANSPARENT, 0.55).set_ease(Tween.EASE_IN)
