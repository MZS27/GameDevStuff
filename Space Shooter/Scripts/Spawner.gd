extends Node2D

const MIN_SPAWN_TIME = 2.0

@onready var spawnTimer := $SpawnTimer
@onready var powerupSpawnTimer := $PowerupSpawnTimer

@export var nextSpawnTime := 5.0
@export var minPowerupSpawnTime := 5.0
@export var maxPowerupSpawnTime := 25.0

var preloadedEnemies := [
	preload("res://Scenes/FastEnemy.tscn"),
	preload("res://Scenes/SlowShooterEnemy.tscn"),
	preload("res://Scenes/BouncingEnemy.tscn"),
]
var preloadedPowerups := [
	preload("res://Scenes/PowerupShield.tscn"),
	preload("res://Scenes/PowerupRapidFire.tscn")
]
var meteorPreload = preload("res://Scenes/Meteor.tscn")

var viewRect

func _ready():
	spawnTimer.start(nextSpawnTime)
	powerupSpawnTimer.start(minPowerupSpawnTime)
	viewRect = get_viewport_rect()

func getRandomSpawnPos() -> Vector2:
	var randomXPos = randi_range(viewRect.position.x, viewRect.end.x)
	return Vector2(randomXPos, position.y)

func _on_spawn_timer_timeout():
	
	if randf() < 0.2:
		var meteor: Meteor = meteorPreload.instantiate()
		meteor.position = getRandomSpawnPos()
		get_tree().current_scene.add_child(meteor)
	else:
		var enemyPreload = preloadedEnemies[randi() % preloadedEnemies.size()]
		var enemy: Enemy = enemyPreload.instantiate()
		enemy.position = getRandomSpawnPos()
		get_tree().current_scene.add_child(enemy)
	
	spawnTimer.start(nextSpawnTime)
	
	if nextSpawnTime > MIN_SPAWN_TIME:
		nextSpawnTime -= 0.04


func _on_powerup_spawn_timer_timeout():
	var powerupPreload = preloadedPowerups[randi() % preloadedPowerups.size()]
	var powerup: Powerup = powerupPreload.instantiate()
	powerup.position = getRandomSpawnPos()
	get_tree().current_scene.add_child(powerup)
	powerupSpawnTimer.start(randf_range(minPowerupSpawnTime, maxPowerupSpawnTime))
