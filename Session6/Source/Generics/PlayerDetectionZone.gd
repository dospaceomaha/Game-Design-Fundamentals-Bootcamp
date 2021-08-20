extends Area2D

# player object
var player = null
# what if can see
func can_see_player():
	return player != null

# what if player entered area

# what if player left area


func _on_PlayerDetectionZone_body_entered(body):
	player = body


func _on_PlayerDetectionZone_body_exited(body):
	player = null



