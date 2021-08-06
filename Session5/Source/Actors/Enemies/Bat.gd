extends KinematicBody2D

# get stats, hurtbox, detectionZone
onready var stats = $Stats
onready var hurtbox = $Hurtbox
onready var playerDetectionZone = $PlayerDetectionZone

export var ACCELERATION = 300
export var MAX_SPEED = 50
export var FRICTION = 200

enum{
	IDLE,
	CHASE
}

var state = IDLE

var velocity = Vector2.ZERO
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	match state:
		IDLE:
			# don't move
			seek_player()
			velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
		CHASE:
			
			chase_player(delta)
	
	velocity = move_and_slide(velocity)

func seek_player():
	if playerDetectionZone.can_see_player():
		state = CHASE

func chase_player(delta):
	#get player
	# move to player
	var player = playerDetectionZone.player
	if player != null:
		accelerate_toward_point(player.global_position, delta)
	else:
		# Reset state
		state = IDLE

func accelerate_toward_point(point, delta):
	# Where are we moving to?
	var direction = global_position.direction_to(point)
	# move
	velocity = velocity.move_toward(direction * MAX_SPEED, ACCELERATION * delta)

func _on_Hurtbox_area_entered(area):
	# Something hit the bat. 
	stats.health -= area.damage


func _on_Stats_no_health():
	queue_free()
