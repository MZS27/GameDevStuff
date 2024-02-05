extends Node2D

var bricksRemaining: int = 10000
var timeElapsed: float = 0
@onready var bricks = $Bricks
@onready var current_time_label = $HUD/CurrentTimeLabel
@onready var best_time_label = $HUD/BestTimeLabel
@onready var paddle_limit_upper = $PaddleLimits/Upper
@onready var paddle_limit_lower = $PaddleLimits/Lower
@onready var player_paddle = $Player

func _ready():
	if GameManager.bestScore != -1:
		best_time_label.set_text(str(GameManager.bestScore))
	bricksRemaining = bricks.get_child_count()
	Messenger.brick_broken.connect(brick_broken)


func _process(delta):
	set_time(delta)
	check_paddle_limit()

func set_time(delta):
	timeElapsed += delta
	current_time_label.set_text(str(int(timeElapsed)))

func brick_broken():
	bricksRemaining -= 1
	check_game_won()

func check_game_won():
	if bricksRemaining <= 0:
		game_won()

func game_won():
	GameManager.set_score(int(timeElapsed))
	Messenger.game_is_won.emit()
	best_time_label.set_text(str(GameManager.bestScore))

func _on_game_over_signal_area_exited(body):
	Messenger.game_is_lost.emit()

func check_paddle_limit():
	if player_paddle.global_position.y > paddle_limit_lower.position.y:
		player_paddle.global_position.y = paddle_limit_lower.position.y
	if player_paddle.global_position.y < paddle_limit_upper.position.y:
		player_paddle.global_position.y = paddle_limit_upper.position.y
