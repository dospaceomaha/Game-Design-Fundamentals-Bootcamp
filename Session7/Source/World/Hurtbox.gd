extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var timer = $Timer
onready var collisionShape = $CollisionShape2D

# what happens when hit
func create_hit_effect():
	queue_free()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
