extends Node

const GRID_SIZE := Vector2(800, 480)
const CELL_SIZE := Vector2(32, 32)

const CELLS_AMOUNT := Vector2(GRID_SIZE.x / CELL_SIZE.x, GRID_SIZE.y / CELL_SIZE.y)

var score := 0 : set = _set_score

signal score_changed(new_score: int)
signal game_start
signal game_over

func _ready() -> void:
	await get_tree().process_frame
	game_start.emit()

func _set_score(new_score: int) -> void:
	score = new_score
	score_changed.emit(score)

func restart() -> void:
	score = 0
	get_tree().reload_current_scene()
