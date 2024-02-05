class_name MiniSnake

var current_position := Vector2() : set = _set_current_position
var previous_position := Vector2()
var size := Vector2()
var color := Color()

func get_rect() -> Rect2:
	return Rect2(current_position, size)

func go_to_prev_position() -> void:
	current_position = previous_position

func _set_current_position(new_position: Vector2) -> void:
	previous_position = current_position
	current_position = new_position
