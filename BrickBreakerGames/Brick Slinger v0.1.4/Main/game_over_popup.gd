extends Control

@onready var title = $ColorRect2/BoxContainer/Title
@onready var label_1 = $ColorRect2/BoxContainer/Label1
@onready var label_2 = $ColorRect2/BoxContainer/Label2

func _ready():
	if GameManager.currentGameWon:
		set_game_won_text()
	else:
		set_game_lost_text()

func _process(delta):
	if Input.is_action_pressed("play_game"):
		play_again()

func set_game_won_text():
	title.set_text("You Won")
	label_1.set_text("Completion Time: %d seconds" % GameManager.currentTime)
	label_2.set_text("Best Time: %d seconds" % GameManager.bestTime)

func set_game_lost_text():
	var bricksDestroyed = GameManager.totalBricksDestroyed
	title.set_text("You Lost")
	if GameManager.totalBricksDestroyed == 1:
		label_1.set_text("You destroyed %d brick!" % bricksDestroyed)
	else:
		label_1.set_text("You destroyed %d bricks!" % bricksDestroyed)
	label_2.set_text("")

func play_again():
	GameManager.play_game()
	queue_free()

func _on_button_pressed():
	play_again()
