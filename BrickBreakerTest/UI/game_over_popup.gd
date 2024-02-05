extends Control

@onready var label_1 = $ColorRect/GridContainer/Label1
@onready var label_2 = $ColorRect/GridContainer/Label2

func _ready():
	set_label_text_1(GameManager.game_over_text_1)
	set_label_text_2(GameManager.game_over_text_2)

func _process(delta):
	if Input.is_action_pressed("ui_accept"):
		GameManager.play_game()
		queue_free()

func set_label_text_1(text: String):
	label_1.set_text(text)
	
func set_label_text_2(text: String):
	label_2.set_text(text)

func _on_button_pressed():
	GameManager.play_game()
	queue_free()
