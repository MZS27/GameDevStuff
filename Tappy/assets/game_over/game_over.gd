extends Control

@onready var game_over_label = $GameOverLabel
@onready var continue_label = $ContinueLabel
@onready var timer = $Timer

var _can_press_space := false

func _ready():
	GameManager.on_game_over.connect(on_game_over)

func _process(delta):
	if _can_press_space == true:
		if Input.is_action_just_pressed("fly"):
			GameManager.load_main_scene()

func _on_timer_timeout():
	transition_label()

func on_game_over() -> void:
	show()
	timer.start()
	
func transition_label() -> void:
	game_over_label.hide()
	continue_label.show()
	_can_press_space = true
