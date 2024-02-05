extends Control


func _on_button_pressed():
	GameManager.play_game()

func _process(delta):
	if Input.is_action_pressed("ui_accept"):
		GameManager.play_game()
