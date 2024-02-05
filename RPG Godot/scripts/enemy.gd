class_name Enemy
extends CharacterBody2D


var speed_inverse := 80
var player = null
var player_chase := false


func _physics_process(delta):
	if player_chase:
		position += (player.position - position) / speed_inverse
		$AnimatedSprite2D.play("walk")
		if (player.position.x - position.x) < 0:
			$AnimatedSprite2D.flip_h = true
		else:
			$AnimatedSprite2D.flip_h = false
	else:
		$AnimatedSprite2D.play("idle")

func _on_detection_area_body_entered(body):
	player = body
	player_chase = true


func _on_detection_area_body_exited(body):
	player = null
	player_chase = false
