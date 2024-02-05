extends Control

@onready var label_1 = $InnerColorRect/BoxContainer/Label1
@onready var label_2 = $InnerColorRect/BoxContainer/Label2

#var text1: String = ""
#var text2: String = ""

func _ready():
	if GameManager.gameWonBool == true:
		set_game_won_text()
	else:
		set_game_lost_text()

func set_game_lost_text():
	label_1.set_text("You Lost")
	label_2.set_text("Better Luck Next Time!")

func set_game_won_text():
	label_1.set_text("Completion Time: %d seconds" % GameManager.currentScore)
	label_2.set_text("Best Time: %d seconds" % GameManager.bestScore)

func _process(delta):
	if Input.is_action_pressed("play_game"):
		play_again()

func _on_button_pressed():
	play_again()

func play_again():
	Messenger.play_game.emit()
	queue_free()
