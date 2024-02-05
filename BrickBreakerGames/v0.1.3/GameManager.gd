extends Node

var levelScene : PackedScene = preload("res://Main/main.tscn")
var gameOverScene: PackedScene = preload("res://UserInterface/game_over_popup.tscn")
var gameWonBool: bool = false
var bestScore: int = -1
var currentScore: int = -1

var gameOverInstance

func _ready():
	Messenger.play_game.connect(play_game)
	Messenger.game_is_lost.connect(game_lost)
	Messenger.game_is_won.connect(game_won)

func play_game():
	get_tree().paused = false
	get_tree().change_scene_to_packed(levelScene)

func game_lost():
	gameWonBool = false
	end_game()

func game_won():
	gameWonBool = true
	end_game()

func set_score(score: int):
	currentScore = score
	if bestScore == -1 or currentScore < bestScore:
		bestScore = currentScore
		

func end_game():
	get_tree().paused = true
	gameOverInstance = gameOverScene.instantiate()
	get_parent().add_child(gameOverInstance)
