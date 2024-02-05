extends Control

@onready var label_1 = $ColorRect/BoxContainer/Label1
@onready var label_2 = $ColorRect/BoxContainer/Label2

var text_1: String
var text_2: String

func _ready():
	if GameManager.game_won_bool == true:
		game_win_text()
	else:
		game_lost_text()
	set_label_text()

func _process(delta):
	if Input.is_action_just_pressed("play_game"):
		play_again()

func game_win_text():
	text_1 = "Completion Time: %d seconds" % GameManager.current_score
	text_2 = "Best Time: %d seconds" % GameManager.best_score

func game_lost_text():
	text_1 = "You lost"
	text_2 = "Better luck next time!"
	

func set_label_text():
	label_1.set_text(text_1)
	label_2.set_text(text_2)

func _on_button_pressed():
	play_again()

func play_again():
	GameManager.play_level()
	queue_free()
