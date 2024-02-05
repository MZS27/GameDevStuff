extends Node2D

var time_elapsed: float = 0
@onready var time_label = $HUD/TimeLabel
@onready var bricks = $Bricks
@onready var best_score_label = $HUD/BestScoreLabel

var bricks_remaining: int = 1000

func _ready():
	Messenger.brick_destroyed.connect(brick_destroyed)
	if GameManager.best_score != -1:
		best_score_label.set_text(str(GameManager.best_score))
	bricks_remaining = bricks.get_child_count()
	print('bricks remaining: ', bricks_remaining)

func _process(delta:float):
	set_score_timer(delta)

func set_score_timer(delta:float):
	time_elapsed += delta
	#print(int(time_elapsed))
	time_label.text = str(int(time_elapsed))

func _on_game_over_signal_body_exited(body_rid, body, body_shape_index, local_shape_index):
	Messenger.game_is_lost.emit()
	get_tree().paused = true

func brick_destroyed():
	bricks_remaining -=1
	check_game_won()

func check_game_won():
	#await get_tree().process_frame
	#if bricks.get_child_count() == 0:
	if bricks_remaining == 0:
		var score_int := int(time_elapsed)
		GameManager.set_best_score(score_int) # 
		best_score_label.set_text(str(GameManager.best_score))
		Messenger.game_is_won.emit()
