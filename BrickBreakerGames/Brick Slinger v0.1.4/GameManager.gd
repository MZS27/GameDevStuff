extends Node

var currentGameWon: bool = false
var bestTime: int = -1
var currentTime: int = -1
var totalBricksDestroyed = 0

var gameOverPopup: PackedScene = preload("res://Main/game_over_popup.tscn")
var mainScene: PackedScene = preload("res://Main/main.tscn")
var gameOverInstance = null

func _ready():
	Messenger.game_is_lost.connect(game_is_lost)
	Messenger.game_is_won.connect(game_is_won) 
	Messenger.play_game.connect(play_game) 

func game_is_won(score):
	currentGameWon = true
	currentTime = score
	if bestTime == -1 or currentTime < bestTime:
		bestTime = currentTime
	game_over_popup()

func game_is_lost(bricksDestroyed):
	currentGameWon = false
	totalBricksDestroyed = bricksDestroyed
	game_over_popup()

func game_over_popup():
	gameOverInstance = gameOverPopup.instantiate()
	get_parent().add_child(gameOverInstance)
	get_tree().paused = true

func play_game():
	totalBricksDestroyed = 0
	currentTime = -1
	get_tree().paused = false
	get_tree().change_scene_to_packed(mainScene)

