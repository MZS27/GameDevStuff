extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _process(delta):
	if Input.is_action_pressed("play_game"):
		Messenger.play_game.emit()


func _on_texture_button_pressed():
	Messenger.play_game.emit()
	
