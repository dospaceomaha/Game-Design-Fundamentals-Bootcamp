extends Node2D


const GrassEffect = preload("res://Source/World/GrassEffect.tscn")

func create_grass_effect():
	var grass_effect_instance = GrassEffect.instance()
	get_parent().add_child(grass_effect_instance)
	grass_effect_instance.global_position = global_position

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _on_Hurtbox_area_entered(area):
	# Animate grass destruction
	create_grass_effect()
	# Delete this object
	queue_free()
