extends StaticBody2D

var destroy_effect = preload("res://ParticleEffects/destroy_particle_effect.tscn")



func destroy():
	#var destroy_particle_effect = destroy_effect.instantiate()
	#add_child(destroy_particle_effect)
	queue_free()
