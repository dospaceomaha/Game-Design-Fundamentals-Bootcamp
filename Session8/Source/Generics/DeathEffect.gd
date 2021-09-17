extends Node2D


onready var audioPlayer = $AudioStreamPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
	audioPlayer.play()

func _on_AudioStreamPlayer_finished():
	queue_free()
