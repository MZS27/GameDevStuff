extends Node2D
class_name Snake

var head:= MiniSnake.new()
var miniSnakes := [] as Array[MiniSnake]

var current_direction := Vector2.RIGHT
var next_direction := Vector2.RIGHT

var tween_move : Tween

signal hit(miniSnake_hit : MiniSnake)

func _ready():
	head.size = Game.CELL_SIZE
	head.color = Colors.SNAKE_HEAD
	miniSnakes.push_front(head)
	
	hit.connect(_on_hit)
	
	tween_move = create_tween().set_loops()
	tween_move.tween_callback(move).set_delay(0.1)

func _process(delta):
	queue_redraw()
	
	
func _draw():
	for miniSnake in miniSnakes:
		draw_rect(miniSnake.get_rect(), miniSnake.color)

func _input(event):
	if event.is_action_pressed("ui_left") and current_direction != Vector2.RIGHT:
		next_direction = Vector2.LEFT
	if event.is_action_pressed("ui_right") and current_direction != Vector2.LEFT:
		next_direction = Vector2.RIGHT
	if event.is_action_pressed("ui_up") and current_direction != Vector2.DOWN:
		next_direction = Vector2.UP
	if event.is_action_pressed("ui_down") and current_direction != Vector2.UP:
		next_direction = Vector2.DOWN

func move() -> void:
	current_direction = next_direction
	var next_position = head.current_position + (current_direction * Game.CELL_SIZE)
	next_position.x = Utils.wall_teleport(next_position.x, Game.GRID_SIZE.x)
	next_position.y = Utils.wall_teleport(next_position.y, Game.GRID_SIZE.y)
	head.current_position = next_position
	
	for i in range(1, miniSnakes.size()):
		miniSnakes[i].current_position = miniSnakes[i-1].previous_position
	
	for i in range(1, miniSnakes.size()):
		if head.get_rect().intersects(miniSnakes[i].get_rect()):
			hit.emit(miniSnakes[i])	
			Game.game_over.emit()
			break

func grow() -> void:
	var miniSnake := MiniSnake.new()
	var lastMiniSnake := miniSnakes.back() as MiniSnake
	miniSnake.current_position = lastMiniSnake.current_position
	miniSnake.color = Colors.SNAKE
	miniSnake.size = Game.CELL_SIZE
	miniSnakes.push_back(miniSnake)
	
	Game.score += 1

func _on_hit(miniSnake_hit : MiniSnake) -> void:
	tween_move.kill()
	
	#Waiting for the hitspotter to get the correct Vector2 position on the grid so it can make that cell red and then moving the snake back to its previous position
	await get_tree().process_frame
	
	for miniSnake in miniSnakes:
		miniSnake.go_to_prev_position()
