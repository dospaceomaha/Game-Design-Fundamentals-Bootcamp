extends Button

func _on_PlayButton_pressed():
	PlayerStats.health = PlayerStats.max_health
	# Open the world scene
	get_tree().change_scene("res://Source/World/World.tscn")
