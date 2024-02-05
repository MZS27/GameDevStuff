extends Node2D

var time_elapsed: float = 0
var game_running: bool

@onready var bricks = $Bricks
@onready var timeLabel := $HUD/TimeLabel
@onready var low_score_label = $HUD/LowScoreLabel

func _ready():
	game_running = true
	Messenger.check_all_bricks_destroyed.connect(check_all_bricks_destroyed)
	if GameManager.lowest_score != -1:
		low_score_label.set_text(str(GameManager.lowest_score))

func _process(delta: float) -> void:
	set_time(delta)
	

func set_time(delta: float) -> void:
	if game_running:
		time_elapsed += delta
		timeLabel.set_text(str(int(time_elapsed)))
		if delta > 1.0:
			print('Delta: ', delta)

func check_all_bricks_destroyed():
	await get_tree().process_frame
	var all_bricks_destroyed: bool = bricks.get_child_count() == 0
	if all_bricks_destroyed:
		game_won()

func _on_game_over_area_exited(body):
	game_running = false 
	Messenger.game_lost.emit()

func game_won():
	var score = int(time_elapsed)
	game_running = false
	GameManager.set_lowest_score(score)
	low_score_label.set_text(str(GameManager.lowest_score))
	Messenger.game_won.emit(score)
