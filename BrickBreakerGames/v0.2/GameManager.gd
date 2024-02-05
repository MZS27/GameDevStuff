extends Node

var best_score: int = -1
var current_score: int = -1
var level_scene: PackedScene = preload("res://Main/main.tscn")
var game_over_scene: PackedScene = preload("res://Main/game_over_popup.tscn")
var game_won_bool := true

var game_over_instance

func _ready():
	Messenger.game_is_won.connect(game_won)
	Messenger.game_is_lost.connect(game_lost)

func game_won():
	game_won_bool = true
	end_level()

func game_lost():
	game_won_bool = false
	end_level()

func end_level():
	get_tree().paused = true
	#game_over_popup()
	game_over_instance = game_over_scene.instantiate()
	get_parent().add_child(game_over_instance)

func set_best_score(score: int):
	current_score = score
	if best_score == -1:
		best_score = score
	elif score < best_score:
		best_score = score

func play_level():
	get_tree().paused = false
	get_tree().change_scene_to_packed(level_scene)

func game_over_popup():
	get_tree().change_scene_to_packed(game_over_scene)

