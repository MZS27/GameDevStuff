extends CharacterBody2D


const speed = 100
var current_dir := "none"

var enemy_in_attack_range = false
var enemy_attack_cooldown = true
var health = 100
var player_alive = true

func _ready():
	$AnimatedSprite2D.play("front_idle")

func _physics_process(delta):
	player_movement(delta)
	enemy_attack()
	
	if health <= 0:
		player_alive = false
		print("player has been killed")
		self.queue_free()

func player_movement(delta):
	if Input.is_action_pressed("ui_right"):
		current_dir = "right"
		play_animation(1)
		velocity.x = speed
		velocity.y = 0
	elif Input.is_action_pressed("ui_left"):
		current_dir = "left"
		play_animation(1)
		velocity.x = -speed
		velocity.y = 0
	elif Input.is_action_pressed("ui_down"):
		current_dir = "down"
		play_animation(1)
		velocity.x = 0
		velocity.y = speed
	elif Input.is_action_pressed("ui_up"):
		current_dir = "up"
		play_animation(1)
		velocity.x = 0
		velocity.y = -speed
	else:
		play_animation(0)
		velocity.x = 0
		velocity.y = 0
	
	move_and_slide()

func play_animation(movement: int):
	var dir = current_dir
	var animatedSprite := $AnimatedSprite2D
	
	if dir == "right":
		animatedSprite.flip_h = false
		if 	movement == 1:
			animatedSprite.play("side_walk")
		elif movement == 0:
			animatedSprite.play("side_idle")
	elif dir == "left":
		animatedSprite.flip_h = true
		if 	movement == 1:
			animatedSprite.play("side_walk")
		elif movement == 0:
			animatedSprite.play("side_idle")
	elif dir == "down":
		animatedSprite.flip_h = false
		if 	movement == 1:
			animatedSprite.play("front_walk")
		elif movement == 0:
			animatedSprite.play("front_idle")
	elif dir == "up":
		animatedSprite.flip_h = false
		if 	movement == 1:
			animatedSprite.play("back_walk")
		elif movement == 0:
			animatedSprite.play("back_idle")


func _on_player_hitbox_body_entered(body):
	if body is Enemy:
		enemy_in_attack_range = true

func _on_player_hitbox_body_exited(body):
	if body is Enemy:
		enemy_in_attack_range = false

func enemy_attack():
	if enemy_in_attack_range and enemy_attack_cooldown == true:
		health -= 20
		enemy_attack_cooldown = false
		$hit_cooldown.start()
		print(health)


func _on_hit_cooldown_timeout():
	enemy_attack_cooldown = true
