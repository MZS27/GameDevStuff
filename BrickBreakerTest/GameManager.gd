extends Node

var game_scene: PackedScene = preload("res://main.tscn")
var game_over_popup: PackedScene = preload("res://UI/game_over_popup.tscn")
var lowest_score : int = -1

var game_over_instance
var game_over_text_1: String
var game_over_text_2: String

func _ready():
	Messenger.game_won.connect(on_game_won)
	Messenger.game_lost.connect(on_game_lost)

func play_game():
	get_tree().paused = false
	get_tree().change_scene_to_packed(game_scene)

func on_game_won(score: int):
	get_tree().paused = true
	game_over_instance = game_over_popup.instantiate()
	game_over_text_1 = "You finished the game in %d seconds!" % score
	game_over_text_2 = "Best time: %d seconds" % lowest_score
	get_parent().add_child(game_over_instance)

func on_game_lost():
	get_tree().paused = true
	game_over_instance = game_over_popup.instantiate()
	game_over_text_1 = "You Lost!"
	game_over_text_2 = "Better Luck Next Time"
	get_parent().add_child(game_over_instance)

func set_lowest_score(score: int):
	if lowest_score == -1 or score < lowest_score:
		lowest_score = score
