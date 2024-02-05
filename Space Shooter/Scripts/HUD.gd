extends Control

@onready var lifeContainer := $LifeContainer
@onready var scoreLabel := $Score
var lifeIconTemplate := preload("res://Scenes/LifeIcon.tscn")

var score: int = 0

func _ready():
	clear_lives()
	Signals.connect("on_player_life_change", Callable(self, "_on_player_life_change"))
	Signals.connect("on_score_increase", Callable(self, "_on_score_increase"))
	
func clear_lives():
	for child in lifeContainer.get_children():
		child.queue_free()
		
func set_lives(lives: int):
	clear_lives()
	for i in range(lives):
		lifeContainer.add_child(lifeIconTemplate.instantiate())

func _on_player_life_change(life: int):
	set_lives(life)

func _on_score_increase(amount: int):
	score += amount
	scoreLabel.text = str(score)
	
