extends Area2D

# get the timer and the shape
onready var timer = $Timer
onready var collisionShape = $CollisionShape2D

const HitEffect = preload("res://Source/Generics/HitEffect.tscn")

func _ready():
	pass # Replace with function body.

func create_hit_effect():
	
	# Create an instance
	var effect = HitEffect.instance()
	# Get the root of the scene
	var main = get_tree().current_scene
	# add hit effect instance
	main.add_child(effect)
	# add hit effect's location
	effect.global_position = global_position
