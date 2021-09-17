extends AnimatedSprite




# What we want to do when the effect is created?
func _ready():
	
	# get the animation
	connect("animation_finished", self, "_on_animation_finished")
	#play 
	play("Animate")


func _on_animation_finished():
	queue_free()
