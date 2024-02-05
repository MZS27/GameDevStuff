extends Node2D

var bricksRemaining: int = 10000
var totalBricks: int = 10000
@onready var bricks = $Bricks
var timeElapsed: float = 0
@onready var currentTimeLabel = $HUD/CurrentTimeLabel
@onready var bestTimeLabel = $HUD/BestTimeLabel

@onready var playerPaddle = $Player
@onready var limitUpper = $PlayerLimits/LimitUpper
@onready var limitLower = $PlayerLimits/LimitLower


func _ready():
	totalBricks = bricks.get_child_count()
	bricksRemaining = totalBricks
	Messenger.brick_broken.connect(brick_broken)
	set_best_time()

func _process(delta):
	set_time(delta)
	check_paddle_limits()

func set_time(delta):
	timeElapsed += delta
	currentTimeLabel.set_text("%d" % int(timeElapsed))

func brick_broken():
	bricksRemaining -= 1
	check_game_won()

func check_game_won():
	if bricksRemaining <= 0:
		Messenger.game_is_won.emit(int(timeElapsed))
		set_best_time()

func _on_game_over_area_exited(body):
	Messenger.game_is_lost.emit(totalBricks - bricksRemaining)

func set_best_time():
	if GameManager.bestTime != -1:
		bestTimeLabel.set_text(str(GameManager.bestTime))

func check_paddle_limits():
	if playerPaddle.global_position.y < limitUpper.global_position.y:
		playerPaddle.global_position.y = limitUpper.global_position.y
	if playerPaddle.global_position.y > limitLower.global_position.y:
		playerPaddle.global_position.y = limitLower.global_position.y
