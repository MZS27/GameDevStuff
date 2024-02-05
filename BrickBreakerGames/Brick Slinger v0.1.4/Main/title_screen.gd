extends Control


func _process(delta):
	if Input.is_action_pressed("play_game"):
		GameManager.play_game()




func _on_button_pressed():
	GameManager.play_game()
